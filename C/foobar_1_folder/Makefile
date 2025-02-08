CC = gcc
TARGET = foobar_1
SRCS = foobar_1.c

$(TARGET): $(SRCS)
	$(CC) -o $@ $^

.PHONY: run clean
run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)