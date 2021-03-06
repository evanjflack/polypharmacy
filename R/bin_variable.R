#' Bin a numeric variable
#' 
#' bin_variable() is a function that creates bins of either equal interval 
#'  length of equal size (quartiles)
#'  
#' @param x numeric vector, variable to be binned
#' @param min numeric, where to start binning
#' @param max numeric, where to end binnig
#' @param int numeric, interval length of bins
#' @param quant interger, number of quantiles
#' @param center logical (default = FALSE), if TRUE then bins are centered 
#'  around seq(min, max, int), otherwise, min is right bound of the bottom bin 
#'  etc...
#'  
#' @return vector of bin labels
#' 
#' @importFrom stats quantile
#'
#' @export
bin_variable <- function(x, min = NULL, max = NULL, int = NULL, quant = NULL, 
                         center = FALSE) {
  # Bins of equal length
  if (is.null(quant)) {
    if (center == FALSE) {
      cuts <- c(-Inf, seq(min, max, int), Inf)
      labs <- seq(min, max + int, int)
    } else if (center == TRUE) {
      cuts <- c(-Inf, seq(min + int/2, max - int/2, int), Inf)
      labs <- seq(min, max, int)
    }
  } else {
    # Bins of equal size (quantiles)
    cuts <- quantile(x, seq(0, 1, 1/quant))
    cuts[1] <- -Inf
    cuts[length(cuts)] <- Inf
    labs <- seq(1, quant)
  }
  bins <- cut(x, breaks = cuts, labels = labs) %>%
    as.character() %>%
    as.numeric()
  
  return(bins)
}