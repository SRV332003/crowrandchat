
# Compiler
CXX = g++

# Directories
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build

# Source files
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Executable name
EXEC = backend.out

# Compiler flags
CXXFLAGS = -I$(INC_DIR) -I/vcpkg/installed/x64-linux/include -std=c++11 -pthread

# Create build directory if it doesn't exist
$(shell mkdir -p $(BUILD_DIR))

# Default target
all: $(EXEC)

# Link object files to create the executable
$(EXEC): $(OBJS)
	$(CXX) $(OBJS) -o $@ 

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean the build directory and executable
clean:
	rm -rf $(BUILD_DIR)/*.o $(EXEC)

run: $(EXEC)
	./$(EXEC)

# Phony targets
.PHONY: all clean run
