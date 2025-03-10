% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IsoriX-dataset.R
\docType{data}
\name{CalibDataAlien}
\alias{CalibDataAlien}
\title{Simulated calibration dataset}
\format{
A *dataframe* with x observations on 6 variables:
\tabular{rlll}{
[, 1] \tab site_ID \tab (*factor*) \tab Identification of the sampling site\cr
[, 2] \tab long \tab (*numeric*) \tab Longitude coordinate (decimal degrees)\cr
[, 3] \tab lat \tab (*numeric*) \tab Latitude coordinate (decimal degrees)\cr
[, 4] \tab elev \tab (*numeric*) \tab Elevation asl (m)\cr
[, 5] \tab sample_ID \tab (*factor*) \tab Identification of the sampled animal\cr
[, 6] \tab tissue.value \tab (*numeric*) \tab Hydrogen delta value of the tissue\cr }
}
\description{
This dataset contains simulated hydrogen delta values for corresponding locations
based on an assumed linear relationship between the animal tissue value and the 
hydrogen delta values in the environment.
The data can be used as an example to fit a calibration model using the
function [calibfit].
}
\details{
Users who wish to use their own dataset for calibration should create a
*dataframe* of similar structure than this one. The columns should possess 
the same names as the ones described above. If the elevation is unknown at the 
sampling sites, elevation information can be extracted from a high resolution elevation
raster using the function [raster::extract]. In this dataset, we
retrieved elevations from the Global Multi-resolution Terrain Elevation Data
2010.
}
\examples{

head(CalibDataAlien)
str(CalibDataAlien)

## The examples below will only be run if sufficient time is allowed
## You can change that by typing e.g. options_IsoriX(example_maxtime = XX)
## if you want to allow for examples taking up to ca. XX seconds to run
## (so don't write XX but put a number instead!)

if(getOption_IsoriX("example_maxtime") > 30) {

## We prepare the precipitation data
GNIPDataDEagg <- prepsources(data = GNIPDataDE)

## We fit the models for Germany
GermanFit <- isofit(data = GNIPDataDEagg)

## We build the isoscape
GermanScape <- isoscape(raster = ElevRasterDE, isofit = GermanFit)

## We create a simulated dataset with 50 site and 10 observations per site
set.seed(2L)
CalibDataAlien <- create_aliens(calib_fn = list(intercept = 3, slope = 0.5, resid_var = 5),
                                isoscape = GermanScape,
                                raster = ElevRasterDE,
                                n_sites = 50,
                                min_n_samples = 10,
                                max_n_samples = 10)
plot(sample_value ~ source_value, data = CalibDataAlien)
abline(3, 0.5)

CalibDataAlien$source_value <- NULL

## Uncomment the following to store the file as we did
#save(CalibDataAlien, file = "CalibDataAlien.rda", compress = "xz")

}


}
\seealso{
[calibfit] to fit a calibration model
}
\keyword{datasets}
