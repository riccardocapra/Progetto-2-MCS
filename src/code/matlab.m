% Definizione dei percosi di elaborazione
PATH = './matrix/';
dinfo = dir('./matrix/*.mat');
outFileResult = './results/matlabResults.csv';

% Creazione del CSV
title = ["matrix", "length", "nnz", "execTime", "memoryUsage", "error"];
writematrix(title, outFileResult, 'WriteMode', 'overwrite', 'Delimiter', 'comma');

for K = 1 : length(dinfo)
	
	% Estrazione della Matrice dal File
    thisfilename = dinfo(K).name;
    fprintf( 'File #%d, "%s" \n', K, thisfilename );

    name = dinfo(K).name;

    loadMatrix = strcat(PATH, dinfo(K).name);
    fprintf("Computing the %s matrix\n", dinfo(K).name);
    load(loadMatrix);

    matrix = Problem.A;
    clear Problem;

    try 
		
		% Settaggio del profiler per la memoria
        profile clear;
        profile('-memory','on');

		% Estazione di informazioni riguardanti la dimensione e il numero di non zero 
        length = size(matrix, 1);
        numZeros = nnz(matrix);

		% Creazione dei risultati "veri"
        xe = ones(length, 1);
        b = matrix * xe;
		
		% Eseguo Cholesky
        solution = solveCholesky(matrix, b);
		
		% Analisi della memoria e del tempo di calcolo
        info = profile('info');
        functions = {info.FunctionTable.FunctionName};
        myfunct = find(strcmp(functions(:),'project1_matlab>solveCholesky'));
        execTime = info.FunctionTable(myfunct).TotalTime;
        memoryUsage = info.FunctionTable(myfunct).TotalMemAllocated;
		
		% Calcolo Errore Relativo
        error = norm(xe - solution) / norm(xe);

    catch exception
        disp(exception.message);
        execTime = 0;
        memoryUsage = 0;
        error = 0;

    end
	
	% Aggiunta risultati al file di output
    toFile = [string(name), string(length), string(numZeros), string(execTime), string(memoryUsage), string(error)];
    writematrix(toFile, outFileResult, 'WriteMode', 'append', 'Delimiter', 'comma');
end
clearvars -except keepVariables exception;

function solution = solveCholesky(A, b)
    R = decomposition(A,'chol','lower');
    solution = R \ b;
end