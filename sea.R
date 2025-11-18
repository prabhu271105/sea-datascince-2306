# Q1 FINAL CLEAN WORKING SCRIPT

# ---- Load Data ----
data <- read.csv("C:/Users/User/Desktop/sea/country_wise_latest1.csv",
                 stringsAsFactors = FALSE)

# ---- Replace invalid values ----
data[data == "" | data == "-" | data == " " | data == "N/A"] <- NA

# ---- Clean column names ----
names(data) <- gsub("\\.+", "_", names(data))
names(data) <- gsub("\\s+", "_", names(data))

country_col <- names(data)[1]   # Country column

# ---- Numeric columns ----
numcols <- c("Confirmed","Deaths","Recovered","Active","New_cases")

for(nc in intersect(numcols, names(data))){
  data[[nc]] <- suppressWarnings(as.numeric(gsub(",", "", data[[nc]])))
}

# ---- Replace NA / Inf with 0 ----
for(col in numcols){
  if(col %in% names(data)){
    data[[col]][is.na(data[[col]])] <- 0
    data[[col]][is.infinite(data[[col]])] <- 0
  }
}

# ---- Derived Metrics ----
data$FatalityRate <- with(data, ifelse(Confirmed > 0, (Deaths/Confirmed)*100, 0))
data$RecoveryRate <- with(data, ifelse(Confirmed > 0, (Recovered/Confirmed)*100, 0))
data$ActiveRate   <- with(data, ifelse(Confirmed > 0, (Active/Confirmed)*100, 0))

# ---- SAFEST TOTALS (No Inf, No NA) ----
totals <- c(
  sum(data$Active, na.rm=TRUE),
  sum(data$Recovered, na.rm=TRUE),
  sum(data$Deaths, na.rm=TRUE)
)

totals[!is.finite(totals)] <- 0

labels <- c("Active", "Recovered", "Deaths")

# ---- OUTPUT PDF ----
pdf("Q1_All_Plots.pdf", width = 11, height = 8.5)

### ---------- PLOT 1 ----------
top10 <- data[order(-data$Confirmed), ][1:10, ]

barplot(
  top10$Confirmed,
  names.arg = top10[[country_col]],
  las = 2, col = "skyblue",
  main =
    