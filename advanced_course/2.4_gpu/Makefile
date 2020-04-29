CC=pgcc
CFLAGS=-O2 -c
LDFLAGS=-O2
SOURCES=mpi_omp_conv.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=mpi_omp_conv

all: $(SOURCES) $(EXECUTABLE)
    
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.c.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf ${OBJECTS}


