cpp() {
    g++ -std=c++11 "$1" && ./a.out && rm -f a.out
}