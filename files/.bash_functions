function summarise_db() {
    local db=$1; shift
    if [[ $# -gt 0 ]]; then
        tables="$@"
    else
        patterns="(SE_|ISO_|idx|raster|virts|wms|vector|spatial|geometr|knn|rl2|ref_sys"
        patterns="${patterns}|settings|sql_statements_log|stored_procedures|stored_variables|data_licenses|topologies)"
        echo ${patterns}
        tables=$(sqlite3 $db ".tables" | tr -s ' ' '\n' | egrep -iv "$patterns")
    fi

    for tbl in $tables; do
        sqlite3 -csv $db "SELECT '$tbl',count(*) from $tbl;"
    done 2>&1 | grep -v sqliterc | grep -v count | tr "," " " | column -t | column
}

export -f summarise_db

function git_clean_branches() {
    local force="no"
    (echo "$@" | grep -qw "\-f") && force="yes"

    # Fetch the latest updates from the remote
    git fetch --prune

    # Loop over all local branches
    for branch in $(git branch --format '%(refname:short)' | egrep -v "(main|master)"); do
        # Check if the branch exists on the remote
        if ! git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
            if [[ "${force}" == "yes" ]]; then
                git branch -D "$branch"
            else 
                echo git branch -D "$branch"
            fi
        fi
    done
}

export -f git_clean_branches


go() {
    local dirs=($HOME/git/anl/* $HOME/git/anl/studies/* $HOME/models/*)
    echo $dirs

    command -v fzf &> /dev/null || sudo apt install fzf

    # Use fzf for interactive fuzzy selection
    local match=$(printf "%s\n" "${dirs[@]}" | fzf)

    if [[ -n "$match" ]]; then
        cd "$match" || return 1
        echo "Changed directory to: $match"
    else
        echo "No match found!"
        return 1
    fi
}
export -f go