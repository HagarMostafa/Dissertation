# allSpace.txt Analysis

## Data facts

### Data structure
Array size: size(allSpace,1) = 29731 (number of rows)
  > Rows Shuffeled using randperm

Array dimensions: size(allSpace,2) = 2D (number of columns)

Data format: (X,Y)
Data limits (x and y axis limits): 
  - Min Point:(-480,-53)
  - Max Point:(480,5000)


## Code notes

### load

Command form: allSpace.txt X

> Use if file name is used to name a variable

Func form (stored in variable) : VariableX = load('allSpace.txt','X');

### Matrix

creation
matrixA = []
matrixB = zeros(rows,columns)
matrixC(rowA,columnA) => point (A,A)
matrixD(:,columnA) all points in ColumnA
matrixE(rowA,:) all points in rowA

matrixF = [x1 y1; x2 y2; x3 y3] 
