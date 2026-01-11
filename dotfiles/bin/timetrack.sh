#!/usr/bin/env bash
# Timewarrior Ultimate Tool - Sync + Management with Gum
# Combines sync functionality with interactive timewarrior management

set -euo pipefail

# Configuration
CONFIG_DIR="$HOME/.config/timew-sync"
CONFIG_FILE="$CONFIG_DIR/config"
TIMEW_DATA_DIR="${TIMEW_DATA_DIR:-$HOME/.local/share/timewarrior}"
SYNC_STATE_DIR="$CONFIG_DIR/state"
BACKUP_DIR="$CONFIG_DIR/backups"
LOCK_FILE="/tmp/timew-sync.lock"

mkdir -p "$CONFIG_DIR" "$SYNC_STATE_DIR" "$BACKUP_DIR"

# Styling functions
style_header() { gum style --foreground 212 --border double --padding "1 2" --align center --width 60 "$@"; }
style_success() { gum style --foreground 76 --bold "$@"; }
style_error() { gum style --foreground 196 --bold "$@"; }
style_warning() { gum style --foreground 220 --bold "$@"; }
style_info() { gum style --foreground 39 "$@"; }

#######################################
# TIMEWARRIOR MANAGEMENT FUNCTIONS
#######################################

# Start tracking
start_tracking() {
    style_header "⏱️  Start Tracking"

    # Get existing tags from history
    existing_tags=$(timew tags 2>/dev/null | tail -n +4 | awk '{print $1}' | sort -u || echo "")

    if [ -n "$existing_tags" ]; then
        # Show option to select existing or create new
        ACTION=$(gum choose "Select from existing tags" "Enter new tags" "Cancel")

        case "$ACTION" in
            "Select from existing tags")
                TAGS=$(echo "$existing_tags" | gum filter --limit 5 --placeholder "Select tags...")
                ;;
            "Enter new tags")
                TAGS=$(gum input --placeholder "Enter tags (space-separated)")
                ;;
            *)
                return
                ;;
        esac
    else
        TAGS=$(gum input --placeholder "Enter tags (space-separated)")
    fi

    if [ -n "$TAGS" ]; then
        timew start $TAGS
        style_success "✓ Started tracking: $TAGS"

        # Show current summary
        echo
        timew summary :ids @1
    fi
}

# Stop tracking
stop_tracking() {
    if timew | grep -q "Tracking"; then
        CURRENT=$(timew | grep "Tracking" | sed 's/Tracking //')

        style_header "⏹️  Stop Tracking"
        style_info "Current: $CURRENT"

        if gum confirm "Stop tracking?"; then
            timew stop
            style_success "✓ Stopped tracking"
            echo
            timew summary :ids @1
        fi
    else
        style_warning "No active tracking session."
    fi
}

# Continue previous task
continue_task() {
    style_header "▶️  Continue Last Task"

    # Get last task tags
    TAGS=$(timew export 2>/dev/null | jq -r '.[0].tags | join(" ")' 2>/dev/null || echo "")

    if [ -n "$TAGS" ]; then
        style_info "Last task: $TAGS"

        if gum confirm "Continue tracking '$TAGS'?"; then
            timew start $TAGS
            style_success "✓ Continued tracking: $TAGS"
        fi
    else
        style_warning "No previous task found."
    fi
}

# Show summary
show_summary() {
    style_header "📊 Time Summary"

    RANGE=$(gum choose \
        "Today (:day)" \
        "Yesterday (:yesterday)" \
        "This week (:week)" \
        "Last week (:lastweek)" \
        "This month (:month)" \
        "Last month (:lastmonth)" \
        "Custom range")

    case "$RANGE" in
        "Today"*) timew summary :day | gum pager ;;
        "Yesterday"*) timew summary :yesterday | gum pager ;;
        "This week"*) timew summary :week | gum pager ;;
        "Last week"*) timew summary :lastweek | gum pager ;;
        "This month"*) timew summary :month | gum pager ;;
        "Last month"*) timew summary :lastmonth | gum pager ;;
        "Custom range")
            START=$(gum input --placeholder "Start date (YYYY-MM-DD)")
            END=$(gum input --placeholder "End date (YYYY-MM-DD)")
            timew summary "$START" - "$END" | gum pager
            ;;
    esac
}

# Edit/Delete intervals
edit_intervals() {
    style_header "✏️  Edit Intervals"

    # Get intervals with better formatting
    INTERVALS=$(timew export 2>/dev/null | jq -r '.[] |
        "@" + (.id // "active" | tostring) + " | " +
        (.start[0:10]) + " " + (.start[11:19]) + " - " +
        (.end[0:19] // "now      ") + " | " +
        (.tags | join(", "))' 2>/dev/null || echo "")

    if [ -z "$INTERVALS" ]; then
        style_warning "No intervals found."
        return
    fi

    SELECTED=$(echo "$INTERVALS" | gum filter --placeholder "Select interval to manage...")

    if [ -n "$SELECTED" ]; then
        ID=$(echo "$SELECTED" | awk '{print $1}')

        # Show preview
        style_info "Selected: $SELECTED"
        echo

        ACTION=$(gum choose "Delete" "Modify tags" "View details" "Cancel")

        case "$ACTION" in
            "Delete")
                if gum confirm "Delete interval $ID?"; then
                    timew delete $ID
                    style_success "✓ Deleted interval $ID"
                fi
                ;;
            "Modify tags")
                NEW_TAGS=$(gum input --placeholder "Enter new tags (space-separated)")
                if [ -n "$NEW_TAGS" ]; then
                    timew tag $ID $NEW_TAGS
                    style_success "✓ Updated tags for $ID"
                fi
                ;;
            "View details")
                timew export $ID | jq '.' | gum pager
                ;;
        esac
    fi
}

# Tag management
manage_tags() {
    style_header "🏷️  Tag Management"

    ACTION=$(gum choose "View all tags" "Rename tag" "Merge tags" "Back")

    case "$ACTION" in
        "View all tags")
            timew tags | gum pager
            ;;
        "Rename tag")
            OLD_TAG=$(timew tags | tail -n +4 | awk '{print $1}' | sort -u | gum filter --placeholder "Select tag to rename")
            if [ -n "$OLD_TAG" ]; then
                NEW_TAG=$(gum input --placeholder "New tag name")
                if [ -n "$NEW_TAG" ] && gum confirm "Rename '$OLD_TAG' to '$NEW_TAG'?"; then
                    # Get all intervals with this tag and update them
                    IDS=$(timew export | jq -r ".[] | select(.tags | index(\"$OLD_TAG\")) | .id" 2>/dev/null)
                    for ID in $IDS; do
                        timew untag @$ID "$OLD_TAG"
                        timew tag @$ID "$NEW_TAG"
                    done
                    style_success "✓ Renamed tag '$OLD_TAG' to '$NEW_TAG'"
                fi
            fi
            ;;
        "Merge tags")
            style_info "Select tags to merge (they will all become one tag)"
            TAGS=$(timew tags | tail -n +4 | awk '{print $1}' | sort -u | gum choose --no-limit)
            if [ -n "$TAGS" ]; then
                TARGET=$(gum input --placeholder "Target tag name")
                if [ -n "$TARGET" ] && gum confirm "Merge selected tags into '$TARGET'?"; then
                    echo "$TAGS" | while read -r TAG; do
                        IDS=$(timew export | jq -r ".[] | select(.tags | index(\"$TAG\")) | .id" 2>/dev/null)
                        for ID in $IDS; do
                            timew untag @$ID "$TAG"
                            timew tag @$ID "$TARGET"
                        done
                    done
                    style_success "✓ Merged tags into '$TARGET'"
                fi
            fi
            ;;
    esac
}

# Quick stats
show_stats() {
    style_header "📈 Statistics"

    # Today's total
    TODAY_TOTAL=$(timew summary :day 2>/dev/null | tail -n 1 | awk '{print $1}')

    # Week's total
    WEEK_TOTAL=$(timew summary :week 2>/dev/null | tail -n 1 | awk '{print $1}')

    # Most used tags this week
    TOP_TAGS=$(timew summary :week 2>/dev/null | tail -n +4 | head -n -1 | sort -k2 -hr | head -5)

    gum join --vertical \
        "$(gum style --foreground 76 --bold "Today's Total:") $TODAY_TOTAL" \
        "$(gum style --foreground 76 --bold "Week's Total:") $WEEK_TOTAL" \
        "" \
        "$(gum style --foreground 212 --bold "Top Tags This Week:")" \
        "$(echo "$TOP_TAGS" | gum format -t code)"

    echo
    gum input --placeholder "Press Enter to continue..." > /dev/null
}

#######################################
# SYNC FUNCTIONS
#######################################

# Initialize config
init_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "# Timewarrior Sync Configuration" > "$CONFIG_FILE"
        echo "# Format: name|user@host|remote_path" >> "$CONFIG_FILE"
    fi
}

# Add sync target
add_sync_target() {
    style_header "➕ Add Sync Target"

    NAME=$(gum input --placeholder "Target name (e.g., work-laptop)")

    # Check if user wants to use SSH config
    USE_SSH_CONFIG=$(gum choose \
        "Use SSH config alias (e.g., 'pi', 'work')" \
        "Enter user@host manually" \
        "Cancel")

    case "$USE_SSH_CONFIG" in
        "Use SSH config alias"*)
            # Show available SSH hosts from config if it exists
            if [ -f "$HOME/.ssh/config" ]; then
                style_info "Available SSH config hosts:"
                grep "^Host " "$HOME/.ssh/config" | awk '{print "  - " $2}' | grep -v "\*" | head -10
                echo
            fi

            SSH_HOST=$(gum input --placeholder "SSH config alias (e.g., pi)")

            # Test connection using just the alias
            if gum spin --title "Testing SSH connection to $SSH_HOST..." -- \
                ssh -o ConnectTimeout=5 -o BatchMode=yes "$SSH_HOST" "echo ok" &>/dev/null; then

                style_success "✓ Connection successful!"
            else
                style_warning "⚠ SSH connection failed."
                if ! gum confirm "Add anyway?"; then
                    return
                fi
            fi
            ;;

        "Enter user@host manually")
            USER=$(gum input --placeholder "SSH user" --value "$USER")
            HOST=$(gum input --placeholder "SSH host (IP or hostname)")
            SSH_HOST="$USER@$HOST"

            # Test connection
            if gum spin --title "Testing SSH connection to $SSH_HOST..." -- \
                ssh -o ConnectTimeout=5 -o BatchMode=yes "$SSH_HOST" "echo ok" &>/dev/null; then

                style_success "✓ Connection successful!"
            else
                style_warning "⚠ SSH connection failed."
                if ! gum confirm "Add anyway?"; then
                    return
                fi
            fi
            ;;

        *)
            return
            ;;
    esac

    REMOTE_PATH=$(gum input --placeholder "Remote timewarrior path" \
        --value "\$HOME/.local/share/timewarrior")

    echo "$NAME|$SSH_HOST|$REMOTE_PATH" >> "$CONFIG_FILE"
    style_success "✓ Target '$NAME' added successfully!"

    style_info "Config entry: $NAME|$SSH_HOST|$REMOTE_PATH"
}

# List targets
list_targets() {
    grep -v "^#" "$CONFIG_FILE" 2>/dev/null | grep -v "^$" || true
}

# Create backup
create_backup() {
    local TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    local BACKUP_FILE="$BACKUP_DIR/timew-backup-$TIMESTAMP.tar.gz"

    tar -czf "$BACKUP_FILE" -C "$(dirname "$TIMEW_DATA_DIR")" \
        "$(basename "$TIMEW_DATA_DIR")" 2>/dev/null

    echo "$BACKUP_FILE"
}

# Sync push
sync_push() {
    local TARGET=$1
    local NAME=$(echo "$TARGET" | cut -d'|' -f1)
    local SSH_HOST=$(echo "$TARGET" | cut -d'|' -f2)
    local REMOTE_PATH=$(echo "$TARGET" | cut -d'|' -f3)

    style_info "📤 Pushing to $NAME..."

    # Create backup
    BACKUP=$(create_backup)
    style_info "Backup: $(basename "$BACKUP")"

    # Ensure remote directory exists
    ssh "$SSH_HOST" "mkdir -p \"$REMOTE_PATH\""

    # Sync
    if gum spin --title "Syncing data..." -- \
        rsync -avz --delete "$TIMEW_DATA_DIR/" "$SSH_HOST:$REMOTE_PATH/"; then
        style_success "✓ Successfully pushed to $NAME"
    else
        style_error "✗ Push failed"
        return 1
    fi
}

# Sync pull
sync_pull() {
    local TARGET=$1
    local NAME=$(echo "$TARGET" | cut -d'|' -f1)
    local SSH_HOST=$(echo "$TARGET" | cut -d'|' -f2)
    local REMOTE_PATH=$(echo "$TARGET" | cut -d'|' -f3)

    style_info "📥 Pulling from $NAME..."

    # Create backup
    BACKUP=$(create_backup)
    style_info "Backup: $(basename "$BACKUP")"

    # Sync
    if gum spin --title "Syncing data..." -- \
        rsync -avz --delete "$SSH_HOST:$REMOTE_PATH/" "$TIMEW_DATA_DIR/"; then
        style_success "✓ Successfully pulled from $NAME"
    else
        style_error "✗ Pull failed"
        return 1
    fi
}

# Smart sync
sync_smart() {
    local TARGET=$1
    local NAME=$(echo "$TARGET" | cut -d'|' -f1)
    local SSH_HOST=$(echo "$TARGET" | cut -d'|' -f2)
    local REMOTE_PATH=$(echo "$TARGET" | cut -d'|' -f3)

    style_info "🔄 Smart sync with $NAME..."

    # Get modification times
    LOCAL_MTIME=$(stat -c %Y "$TIMEW_DATA_DIR/data" 2>/dev/null || echo 0)
    REMOTE_MTIME=$(ssh "$SSH_HOST" "stat -c %Y \"$REMOTE_PATH/data\" 2>/dev/null || echo 0" 2>/dev/null || echo 0)

    if [ "$LOCAL_MTIME" -gt "$REMOTE_MTIME" ]; then
        style_info "Local is newer → Pushing"
        sync_push "$TARGET"
    elif [ "$REMOTE_MTIME" -gt "$LOCAL_MTIME" ]; then
        style_info "Remote is newer → Pulling"
        sync_pull "$TARGET"
    else
        style_info "✓ Already in sync!"
    fi
}

# Perform sync
perform_sync() {
    style_header "🔄 Sync Timewarrior"

    if [ ! -s "$CONFIG_FILE" ]; then
        style_warning "No sync targets configured."
        if gum confirm "Add one now?"; then
            add_sync_target
        fi
        return
    fi

    # Select target
    TARGET=$(list_targets | gum choose --header "Select sync target:")

    if [ -z "$TARGET" ]; then
        return
    fi

    NAME=$(echo "$TARGET" | cut -d'|' -f1)

    # Select method
    METHOD=$(gum choose \
        "Smart Sync (auto-detect)" \
        "Push (local → remote)" \
        "Pull (remote → local)" \
        "Cancel")

    case "$METHOD" in
        "Smart"*) sync_smart "$TARGET" ;;
        "Push"*) sync_push "$TARGET" ;;
        "Pull"*) sync_pull "$TARGET" ;;
    esac
}

# Sync status
view_sync_status() {
    style_header "📊 Sync Status"

    if [ ! -s "$CONFIG_FILE" ]; then
        style_warning "No sync targets configured."
        return
    fi

    list_targets | while IFS='|' read -r NAME SSH_HOST REMOTE_PATH; do
        echo
        gum style --foreground 212 --bold "Target: $NAME"
        gum style --foreground 39 "  Host: $SSH_HOST"

        if ssh -o ConnectTimeout=5 "$SSH_HOST" "test -d \"$REMOTE_PATH\"" 2>/dev/null; then
            LOCAL_COUNT=$(find "$TIMEW_DATA_DIR" -name "*.data" 2>/dev/null | wc -l)
            REMOTE_COUNT=$(ssh "$SSH_HOST" "find \"$REMOTE_PATH\" -name '*.data' 2>/dev/null | wc -l" 2>/dev/null)

            gum style --foreground 76 "  ✓ Connected"
            gum style --foreground 39 "  Local entries: $LOCAL_COUNT"
            gum style --foreground 39 "  Remote entries: $REMOTE_COUNT"
        else
            gum style --foreground 196 "  ✗ Cannot connect"
        fi
    done

    echo
    gum input --placeholder "Press Enter to continue..." > /dev/null
}

# Restore backup
restore_backup() {
    style_header "♻️  Restore Backup"

    if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]; then
        style_error "No backups found"
        return
    fi

    BACKUP=$(ls -1t "$BACKUP_DIR" | gum choose --header "Select backup to restore:")

    if [ -n "$BACKUP" ]; then
        style_info "Backup: $BACKUP"

        if gum confirm "Restore this backup? (Current data will be replaced)"; then
            create_backup

            gum spin --title "Restoring..." -- \
                tar -xzf "$BACKUP_DIR/$BACKUP" -C "$HOME" --strip-components=2

            style_success "✓ Backup restored"
        fi
    fi
}

#######################################
# MAIN MENU
#######################################

main_menu() {
    while true; do
        clear

        # Show current tracking status
        if timew | grep -q "Tracking"; then
            CURRENT=$(timew | grep "Tracking" | sed 's/Tracking //')
            style_header "⏱️  Timewarrior - Currently Tracking: $CURRENT"
        else
            style_header "⏱️  Timewarrior Manager"
        fi

        echo

        CHOICE=$(gum choose \
            "⏱️  Start Tracking" \
            "⏹️  Stop Tracking" \
            "▶️  Continue Last Task" \
            "📊 Show Summary" \
            "📈 Quick Stats" \
            "✏️  Edit Intervals" \
            "🏷️  Manage Tags" \
            "" \
            "🔄 Sync Now" \
            "📡 Sync Status" \
            "➕ Add Sync Target" \
            "♻️  Restore Backup" \
            "" \
            "🚪 Exit")

        case "$CHOICE" in
            "⏱️  Start Tracking") start_tracking ;;
            "⏹️  Stop Tracking") stop_tracking ;;
            "▶️  Continue Last Task") continue_task ;;
            "📊 Show Summary") show_summary ;;
            "📈 Quick Stats") show_stats ;;
            "✏️  Edit Intervals") edit_intervals ;;
            "🏷️  Manage Tags") manage_tags ;;
            "🔄 Sync Now") perform_sync ;;
            "📡 Sync Status") view_sync_status ;;
            "➕ Add Sync Target") add_sync_target ;;
            "♻️  Restore Backup") restore_backup ;;
            "🚪 Exit") exit 0 ;;
            "") continue ;;
        esac

        echo
        gum input --placeholder "Press Enter to continue..." > /dev/null 2>&1 || true
    done
}

#######################################
# COMMAND LINE INTERFACE
#######################################

case "${1:-menu}" in
    start)
        shift
        if [ $# -eq 0 ]; then
            start_tracking
        else
            timew start "$@"
        fi
        ;;
    stop)
        stop_tracking
        ;;
    continue|cont)
        continue_task
        ;;
    edit)
        edit_intervals
        ;;
    summary|sum)
        shift
        show_summary
        ;;
    tags)
        manage_tags
        ;;
    stats)
        show_stats
        ;;
    sync)
        perform_sync
        ;;
    sync-status)
        view_sync_status
        ;;
    sync-auto)
        # For cron: auto-sync all targets
        init_config
        if [ -s "$CONFIG_FILE" ]; then
            list_targets | while IFS='|' read -r NAME SSH_HOST REMOTE_PATH; do
                sync_smart "$NAME|$SSH_HOST|$REMOTE_PATH" || true
            done
        fi
        ;;
    add-target)
        add_sync_target
        ;;
    menu|"")
        init_config
        main_menu
        ;;
    help|--help|-h)
        cat << 'EOF'
Timewarrior Ultimate Manager - Sync + Management with Gum

USAGE:
    timew-manager [COMMAND]

COMMANDS:
    start           Start tracking (interactive or with tags)
    stop            Stop current tracking
    continue        Continue last task
    summary         Show time summary
    stats           Show quick statistics
    edit            Edit/delete intervals
    tags            Manage tags

    sync            Sync with remote
    sync-status     Show sync status
    sync-auto       Auto-sync all targets (for cron)
    add-target      Add new sync target

    menu            Show interactive menu (default)
    help            Show this help

EXAMPLES:
    timew-manager                    # Interactive menu
    timew-manager start              # Start tracking with UI
    timew-manager start coding work  # Start tracking "coding work"
    timew-manager sync               # Sync interactively

CRON AUTOMATION:
    Add to crontab for auto-sync:
    */30 * * * * /path/to/timew-manager sync-auto

EOF
        ;;
    *)
        # Pass through to timew
        timew "$@"
        ;;
esac
