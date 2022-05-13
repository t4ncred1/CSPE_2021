{
    gsub(/\//, " ")
    sub(/\[/, "");
    gsub(/:/, " ");
    DATE = sprintf("%s %s %s %s:%s:%s", $4, $5, $6, $7, $8, $9, $10 );
    cmd = "date -d \""DATE"\" +%s";
    cmd | getline out;
    print out
}
