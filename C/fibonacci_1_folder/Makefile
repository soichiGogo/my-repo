CC = gcc
TARGET = fibonacci_1
SRCS = fibonacci_1.c

$(TARGET): $(SRCS)
	$(CC) -o $@ $^

.PHONY: run clean
run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)