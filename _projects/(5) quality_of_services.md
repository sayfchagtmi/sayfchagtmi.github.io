---
name: Quality Of Services
tools: [Leaflet, DataViz, RShiny]
image: /img/projects/quality_of_services/frederik-lipfert-cWtsPbJtIvs-unsplash.jpg
description: This project is about a visualization of the Tunisian's quality of services comparing the 3 major internet providers' cellular data (2017).
---

## Introduction

This project is inspired by the annual reports issued by the ["National Instance of Telecommunications of Tunisia"](http://www.intt.tn/fr/index.php?home).
I used data from 2017 annual report for 2G and 3G networks ([:link: Link](https://github.com/sayfchagtmi/Qos_3G-2G_Tunisie/raw/master/2g3g-f.xlsx)).
I used these main Key Performance Indicators (KPIs):

* **<u>For Voice Services:</u>**
    - **Blocking rate (BR,%)**: Ratio of the number of blocked call attempts to the total number of call attempts made. A call attempt is considered blocked if the ring back is not received after 20 seconds. The call attempts are spaced by a variable time interval equal to at least 30 seconds.
    - **Interruption rate (IR, %)**: Ratio of the number of 2-minute calls cut off before the end of this time to the total number of unblocked calls. - Mean Opinion Score (MOS): The score assigned to a call following an evaluation of its auditory quality using a scoring algorithm based on calls with an average duration of 2 minutes.

* **<u>For Data Service:</u>**

    - **Access success rate (ASR, %)**: The ratio of the number of access attempts to a set of websites or a set of HTTP streaming videos that were not blocked to the total number of access attempts.

    - **Average 2G/3G browsing speed (ABS , kbps)**: The ratio of the sum of bits received during an HTTP browsing session to the duration of that session.

    - **Successful download/send rate (SD/SR,%)**: The ratio of the number of successful downloads/sends to the total number of downloads/sends.

    - **Average file download/sending rate (AFD/SR, Mbps)**: Ratio of the sum of bits received/sent during a File Transfer Protocol (FTP) session to the duration of that session.

Data will be plotted by gouvernorate (24) and by Internet Provider Service (IPS).
In Tunisia, we have 3 main IPS for cellular data:
    - "Tunisie Telecom"
    - Ooredoo
    - Orange Tunisie

## Data preprocessing
* In order to represent the data on a leaflet map I used [:snake: “geopy”](https://pypi.org/project/geopy/) (Python package) in order to extract longitude and latitude.

```python
import pandas as pd 
from geopy.geocoders import Nominatim

#Importer les données
df = pd.read_excel("2g3g-f.xlsx")

#Définir les régions et les opérateurs.
op = []
reg = []
for i in range(len(df)):
    s = df['gouvernorat'][i]
    l= s.split(": ")
    if(l[1] == "TT"):
        op.append("Tunisie Télécom")
    if(l[1] == "OT"):
        op.append("Orange Tunisie")
    if(l[1] == "OO"):
        op.append("Ooredoo")
    reg.append(l[0])
    
df.gouvernorat = reg
df['opérateur'] = op

# Chercher les longitudes et latitudes.
geolocator = Nominatim(user_agent="https://maps.google.com/")
lat = []
long = []
for i in range(len(df)):
    try:
        location = geolocator.geocode(df.gouvernorat[i])
        lat.append(location.latitude)
        long.append(location.longitude)
    except:
        lat.append("NAN")
        long.append("NAN")
        
df['Longitude'] = long
df['Latitude'] = lat
pd.DataFrame.to_csv(df,"data.csv")

```

## Shiny application

* In the application you, you'll find 3 tabs:
    - The first one is the Tunisian map that contains the presented informations for every governorate and for every IPS.
    - The second tab contains data preview.
    - Finally, you'll find the explanations of the KPIs.

* [:link: Link to the Shiny App.](https://sayfchagtmi.shinyapps.io/Tunisia_Qos_2G3G/)

* [:octocat: Link to the Github Repo.](https://github.com/sayfchagtmi/Qos_3G-2G_Tunisie)

<iframe src="https://sayfchagtmi.shinyapps.io/Tunisia_Qos_2G3G/" width="100%" height="600px">