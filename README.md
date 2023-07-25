
 # Detecting Outliers in GRACE Satellite Observation Instruments
 
In theory, GRACE L1B data product can be used directly for gravity field recovery, but there are outliers in the data that need to be removed before the gravity field recovery processing. Data screening for 15 years of GRACE data and for every instrument is a challenging task. The cause of systematic errors and outliers has been studied by (Goswami, 2018) and (Klinger, 2018) but in this work we have only focused on finding an effective way to find outliers in GRACE data.
The overall error (including outliers) in the instrument data and background models are projected in range rate residuals in
case of GRACE gravity field recovery, because the main observation is range rate. Figure 2 shows how outliers in range rate AOC are mapped into range rate residuals. Therefore, removing the outliers from the instrument observation guarantees a stationary or homogeneous residuals, that can be used to build full (not diagonal) error variance covariance matrix of observation.
 
![okresAOC_D0rl03ult_030800](https://github.com/Darbeheshti/GRACE-instruments-outliers/assets/50994293/5d1bc7ab-a353-471c-8f4b-6d2f45d3f6df)

The full time series of GRACE AIUB-RL03 gravity solution based on outleir detection in this repository is available and can be accessed from the International Center for Global Earth Models website:
Darbeheshti, N, Lasser, M, Meyer, U, Arnold, D, and Jaeggi, A 2023 AIUB-G3P GRACE monthly gravity field solutions. DOI: https://doi.org/10.5880/ICGEM.2023.001.
This paper explains the approach in more detail.
https://doi.org/10.5194/essd-2023-72
