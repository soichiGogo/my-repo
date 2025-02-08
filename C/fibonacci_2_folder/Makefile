CC = gcc
TARGET = fibonacci_2
SRCS = fibonacci_2.c

$(TARGET): $(SRCS)
	$(CC) -o $@ $^

.PHONY: run clean
run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)