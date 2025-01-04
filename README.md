# Data Engineering ZoomCamp - Module 4 - Analytics Engineering

This is the fourth deliverable for the DEZC. In this repository you can find
the code generated while following the classes and also the code generated to
solve the homework.

For the homework, a staging model have been generated where the data is
imported and some cleanup is done: null pick up and drop off locations are
removed.
Also, as required by the homework, a filter to stage only trips dated on 2019
have been added.

A core model for that table have also been generated where that data is
enriched with the zone information.

Finally, another core model that merges all the different services have also
been generated.
This model just queries the staging models of the different services for the
data that all of them share (id, pick up and drop off times and locations)
and merge that data again with the zone information.

Another strategy could had been the use of the already existing fact_trips
with the data for the yellow and green services with the previously created
fact_fhv_trips.
That would avoid the need to do an extra merge of the zone data.
On the other size, a drawback would had been that the table materialization
would had to wait for those tables to be generated before starting with this
one, while with the approach I choose the generation can be done in parallel.

In a production environment, some benchmarking would have to be done to choose
the best path.
Probably it would be better to use the second option, as using already computed
data should lower the costs and increase the efficiency.

As required for the homework, the data generated can be visualized in [Looker
Studio](https://lookerstudio.google.com/s/rxLW7RRKgqM)