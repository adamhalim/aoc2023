#include <cctype>
#include <fstream>
#include <iostream>
#include <set>
#include <sstream>
#include <string>
#include <vector>

int line_width;
std::set<int> check_boundaries_parts(std::vector<std::string> &coordinates,
                                     int x, int y);
int check_boundaries_ratios(std::vector<std::string> &coordinates, int x,
                            int y);
std::set<int> find_adjacent_part_numbers(std::vector<std::string> &coordinates,
                                         int x, int y);
std::set<int> find_gear_ratios(std::vector<std::string> &coordinates, int x,
                               int y);
int search_backwards(std::vector<std::string> &coordinates, int x, int y);
int search_forwards(std::vector<std::string> &coordinates, int x, int y);
int find_part_number(std::vector<std::string> &coordinates, int x, int y);

int main(int argc, char **argv) {

  std::fstream input;

  input.open(argv[1]);
  std::string line;

  while (std::getline(input, line)) {
    std::istringstream iss(line);
    line_width = line.size();
    break;
  }
  input.seekg(0, std::ios::beg);

  std::vector<std::string> coordinate_map;
  coordinate_map.push_back(std::string(line_width + 2, '.'));

  int row_count = 0;
  while (std::getline(input, line)) {
    std::istringstream iss(line);
    coordinate_map.push_back("." + line + ".");
    row_count++;
  }

  int sum_part_numbers = 0;
  int sum_gear_ratios = 0;
  for (int i = 0; i < row_count; i++) {
    std::string line = coordinate_map[i];
    for (int j = 0; j < line_width; j++) {
      auto part_numbers = check_boundaries_parts(coordinate_map, j, i);
      for (const auto part_number : part_numbers) {
        sum_part_numbers += part_number;
      }
      sum_gear_ratios += check_boundaries_ratios(coordinate_map, j, i);
    }
  }

  std::cout << "Part one : " << sum_part_numbers << std::endl;
  std::cout << "Part two: " << sum_gear_ratios << std::endl;

  return 0;
}

std::set<int> check_boundaries_parts(std::vector<std::string> &coordinates,
                                     int x, int y) {
  char c = coordinates[y][x];
  if (c == '.')
    return std::set<int>();

  if (!std::isdigit(c)) {
    // Found a symbol
    return find_adjacent_part_numbers(coordinates, x, y);
  }

  return std::set<int>();
}

int check_boundaries_ratios(std::vector<std::string> &coordinates, int x,
                            int y) {
  char c = coordinates[y][x];
  if (c == '*') {
    std::set<int> parts_numbers = find_adjacent_part_numbers(coordinates, x, y);
    if (parts_numbers.size() == 2) {
      auto first_gear = *(parts_numbers.begin());
      parts_numbers.erase(first_gear);
      auto second_gear = *(parts_numbers.begin());
      return first_gear * second_gear;
    }
  }

  return 0;
}

std::set<int> find_adjacent_part_numbers(std::vector<std::string> &coordinates,
                                         int x, int y) {
  std::set<int> found_parts;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      if (i == 0 && j == 0)
        continue;

      if (std::isdigit(coordinates[y + i][x + j])) {
        int part_number = find_part_number(coordinates, x + j, y + i);
        found_parts.insert(part_number);
      }
    }
  }

  return found_parts;
}

int find_part_number(std::vector<std::string> &coordinates, int x, int y) {
  int offset = search_backwards(coordinates, x, y);
  int digit_len = search_forwards(coordinates, x - offset, y);

  std::string line = coordinates[y];
  std::string part_number = line.substr(x - offset + 1, --digit_len);
  return std::stoi(part_number);
}

int search_backwards(std::vector<std::string> &coordinates, int x, int y) {
  int offset = 0;
  if (std::isdigit(coordinates[y][x - offset])) {
    while (std::isdigit(coordinates[y][x - offset]) && x - offset > 0) {
      offset++;
    }
  } else {
    offset = 0;
  }

  return offset;
}

int search_forwards(std::vector<std::string> &coordinates, int x, int y) {
  int digit_length = 1;
  while (std::isdigit(coordinates[y][x + digit_length]) &&
         x + digit_length <= line_width) {
    digit_length++;
  }
  return digit_length;
}

std::set<int> find_gear_ratios(std::vector<std::string> &coordinates, int x,
                               int y) {
  int offset = search_backwards(coordinates, x, y);
  int digit_len = search_forwards(coordinates, x - offset, y);

  return std::set<int>();
}