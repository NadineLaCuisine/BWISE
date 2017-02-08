CC=g++
CFLAGS=  -Wall  -Ofast -std=c++11  -flto -pipe -funit-at-a-time  -Wfatal-errors
CFLAGS+=$(LOL)
LDFLAGS=-flto



ifeq ($(gprof),1)
CFLAGS=-std=c++0x -pg -O4 -march=native
LDFLAGS=-pg
endif

ifeq ($(valgrind),1)
CFLAGS=-std=c++0x -O4 -g
LDFLAGS=-g
endif



EXEC=bwise n50 sequencesToNumbers numbersToSequences numbersFilter

all: $(EXEC)


bwise: bwise.o
	$(CC) -o $@ $^ $(LDFLAGS)

n50: n50.o
	$(CC) -o $@ $^ $(LDFLAGS)

sequencesToNumbers: sequencesToNumbers.o
	$(CC) -o $@ $^ $(LDFLAGS)

numbersFilter: numbersFilter.o
	$(CC) -o $@ $^ $(LDFLAGS)

numbersToSequences: numbersToSequences.o
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.cpp %.h
	$(CXX) -o $@ -c $< $(CFLAGS)


clean:
	rm -rf *.o
	rm -rf $(EXEC)

