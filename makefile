###############################
## Choose invDMRG solver     ##
## by adding one of the      ##
## following to the CC_FLAGS ##
## -DUse_Def                 ##
## -DUse_sDef                ##
## -DUse_Indef (recommended) ##
## -DUse_sIndef              ##
###############################
# For this makefile to work,
# (1) the user need to replace EIGEN3_PARENT_FOLDER/ with Eigen3's parent folder
# (2) the user need to replace ARPACK_LIB_FOLDER/ with ARpACK's library folder
###############################

# Declaration of variables

# (1) If using GNU compiler, uncomment the next two lines
# CC = g++-5
# CC = g++
# CC_FLAGS = -fopenmp -lgfortran -llapack -lblas -I EIGEN3_PARENT_FOLDER/ -L ARPACK_LIB_FOLDER/ -larpack -std=c++11 -O3 -DUse_Indef -DNDEBUG -W
# CC_FLAGS = -fopenmp -lgfortran -llapack -lblas -larpack -I ~ -std=c++11 -O3 -DUse_Indef -DNDEBUG -W
# CC_FLAGS = -fopenmp -lgfortran -llapack -lblas -larpack -std=c++11 -O3 -DUse_Indef -DNDEBUG -W

# (2) If using Intel compiler + MKL, uncomment the next two lines
 CC = icpc
# CC_FLAGS = -openmp -parallel -mkl=parallel -I EIGEN3_PARENT_FOLDER/ -larpack -std=c++11 -O3 -DUse_Indef -DUse_MKL -DNDEBUG -W
 CC_FLAGS = -openmp -parallel -mkl=parallel -I ~ -larpack -std=c++11 -O3 -DUse_Indef -DUse_MKL -DNDEBUG -W


# As an example,
# (1) on my laptop, I would use
# CC = icpc
# CC_FLAGS = -openmp -parallel -mkl=parallel -I ~/ -L /opt/local/lib -larpack -std=c++11 -O3 -DUse_Indef -DUse_MKL -DNDEBUG -W

# (2) on campus cluster (ARPACK is provided by default), after loading intel compiler, I would use
# CC = icpc
# CC_FLAGS = -openmp -parallel -mkl=parallel -I ~/ -larpack -std=c++11 -O3 -DUse_Indef -DUse_MKL -DNDEBUG -W

# File names
EXEC = run
SOURCES = $(wildcard ./src/*.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

# Main target
$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) $(CC_FLAGS) -o $(EXEC)

# To obtain object files
%.o: %.cpp
	$(CC) -c $(CC_FLAGS) $< -o $@

# To remove generated files
clean:
	rm -f $(EXEC) $(OBJECTS)
	
