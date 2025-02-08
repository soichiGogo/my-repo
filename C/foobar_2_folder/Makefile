CC = gcc
TARGET = foobar_2
SRCS = foobar_2.c

$(TARGET): $(SRCS)
	$(CC) -o $@ $^

.PHONY: run clean
run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)
	