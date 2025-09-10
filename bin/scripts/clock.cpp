#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
#include <thread>

void print_time()
{
    auto now = std::chrono::system_clock::now();
    std::time_t now_c = std::chrono::system_clock::to_time_t(now);
    std::tm local_tm = *std::localtime(&now_c);
    std::cout << std::put_time(&local_tm, "%a %d/%m - %H:%M") << std::endl;
}

int get_unixtime_epoch()
{
    auto now = std::chrono::system_clock::now();
    std::time_t now_c = std::chrono::system_clock::to_time_t(now);
    return now_c;
}

int main()
{
    const int delay = 5;
    const int delay_offset = delay - (get_unixtime_epoch() % 5);

    print_time();
    std::this_thread::sleep_for(std::chrono::seconds(delay_offset));

    for ( ;; ) {
        print_time();
        std::this_thread::sleep_for(std::chrono::seconds(delay));
    }

    return 0;
}
