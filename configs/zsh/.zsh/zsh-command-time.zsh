# Simple Zsh prompt with Git status.

local GITSTATUS_DIR=$HOME/.zsh/plugins/zsh-command-time

# Check if directory exists
if [ ! -d $GITSTATUS_DIR ]; then
    git clone https://github.com/popstas/zsh-command-time $GITSTATUS_DIR
fi

# Source from $GITSTATUS_DIR or from the same directory
# in which the current script resides if the variable isn't set.
source "${GITSTATUS_DIR:-${${(%):-%x}:h}}/command-time.plugin.zsh" || return

ZSH_COMMAND_TIME_MIN_SECONDS=3
ZSH_COMMAND_TIME_MSG=""
ZSH_COMMAND_TIME_EXCLUDE=(nvim vim v nano man)

zsh_command_time() {
    if [ -n "$ZSH_COMMAND_TIME" ]; then
        hours=$(($ZSH_COMMAND_TIME/3600))
        min=$(($ZSH_COMMAND_TIME/60))
        sec=$(($ZSH_COMMAND_TIME%60))
        if [ "$ZSH_COMMAND_TIME" -le 60 ]; then
            timer_show="\e[33m${ZSH_COMMAND_TIME}s\e[0m"
        elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
            timer_show="\e[33m${min}m${sec}s\e[0m"
        else
            if [ "$hours" -gt 0 ]; then
                min=$(($min%60))
                timer_show="\e[31m${hours}h${min}min${sec}s\e[0m"
            else
                timer_show="\e[31m${min}m${sec}s\e[0m"
            fi
        fi
        printf "$timer_show"
    fi
}
