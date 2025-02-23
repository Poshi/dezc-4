# Data Engineering ZoomCamp - Module 4 - Analytics Engineering

This is the fourth deliverable for the DEZC. In this repository you can find
the code generated while following the classes and also the code generated to
solve the homework.

For the homework, staging models have been generated where the data is
imported and some cleanup is done: null pick up and drop off locations are
removed.

A core model for that table have also been generated where that data is
enriched with the zone information and some attributes to ease the posterior
filtering.

Another core model that merges Green and Yellow services have also
been generated, and a different one for the FHV data.
Those models just query the staging models of the different services for the
data that all of them share (id, pick up and drop off times and locations)
and merge that data again with the zone information.

All models required by the homework have been created as requested, except one
of then that contains a typo in the homework and had to be changed in order
to get results that matched some of the expected answers.

Finally, models that answer the specific homework questions have also been
created.

All the data have been created as views except the models that serve as
foundation for the homework questions, as these are the queries that the
business owner would do and need to be answered quickly.