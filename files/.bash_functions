function summarise_db() {
    local db=$1
    for tbl in $(sqlite3 $db ".tables"); do
        sqlite3 $db "SELECT '$tbl',count(*) from $tbl;"
    done 2>&1 | grep -v sqliterc | grep -v count
}

export -f summarise_db