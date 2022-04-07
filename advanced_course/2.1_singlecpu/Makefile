CC=mpicc
CFLAGS=-O2 -fopenmp -c
LDFLAGS=-O2 -fopenmp
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


