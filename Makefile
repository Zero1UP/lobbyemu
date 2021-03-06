TARGET = lobbyemu
LIBS =
CC = gcc
CXX = g++
GIT_VERSION := $(shell git describe --dirty --always)
CFLAGS = -g -Wall -Iinclude -DGIT_VERSION=\"$(GIT_VERSION)\"
CPPFLAGS = $(CFLAGS)

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
HEADERS = $(wildcard *.h)

%.o: %.c $(HEADERS)
	$(CXX) $(CPPFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) $(CPPFLAGS) $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET)
