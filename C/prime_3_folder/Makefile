CC = gcc
CFLAGS = -O2 # 最適化オプションを追加
TARGET = prime_3
SRCS = prime_3.c

$(TARGET): $(SRCS)
	$(CC)$(CFLAGS) -o $@ $^

.PHONY: run clean
run: $(TARGET)
	./$(TARGET) 1000000

clean:
	rm -f $(TARGET)