CC=pgcc
TARGET=-ta=tesla:cc35,cc60,cc70
CFLAGS=-acc -fast $(TARGET) -Minfo=accel -c
LDFLAGS=-acc $(TARGET) -fast 
SOURCES=mpi_omp_conv.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=mpi_omp_conv

all: $(SOURCES) $(EXECUTABLE)
    
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.c.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf $(OBJECTS) $(EXECUTABLE)


