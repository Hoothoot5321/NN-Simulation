# Program der simulere et neuralt netævrk.

Visuelt repræsentation af nøjagtigheden af et neuralt netværk under dens træning.

Hoved programmet er **NN Simulation.exe**

Datasættet der bruges er (Standard OCR dataset)[https://www.kaggle.com/datasets/preatcher/standard-ocr-dataset]

Den er splittet i to dele, en udelukkende med tallene, og en med tal og bogstaver.

Programmet er temmligt ressource krævene, og kan tage op til 4gb ram.

Man kan ændre mængden af trænings sæt, lag og neuroner ved Setting/settings.json.

Undgå at sæt learning til 0.1 eller højere. 
Grunden til dette er at tallene kommer til at blive for store eller små, som gør at de overgår hvad processing kan klare.
Processings float(descimal tal) er nemlig kun 32 bit,  så de kan kun være så store som 3.40282347E+38 eller så lille som -3.40282347E+38.
Unde træningsprocessen vil nogle af værdierne overgå dette, som går at det bare bliver til NaN, som gør at programmet går i stykker.
