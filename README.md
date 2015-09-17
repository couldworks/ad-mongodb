Dockerized MongoDb
====================

A docker image for running production-level MongoDb for [landsat-api](https://github.com/developmentseed/landsat-api)

MongoDB version
---------------

Different versions are built from different folders. The images are also hosted on [DockerHub](https://hub.docker.com/r/astrodigital/ad-monogodb/)

Usage
-----

To build the image go the folder of the version you need and execute the following command:

        docker build -t 'astrodigital/ad-monogodb' 3.0/.

You can also download the latest version for Docker hub;

        docker pull astrodigital/ad-monogodb:latest


Running the MongoDB server
--------------------------

Run the following command to start MongoDB:

        docker run -d -p 27017:27017 --name mongodb astrodigital/ad-monogodb:latest

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

        docker logs mongodb

You will see an output like the following:

        ========================================================================
        You can now connect to this MongoDB server using:

            mongo admin -u admin -p 5elsT6KtjrqV --host <host> --port <port>
            mongo landsat-api -u landsatuser -p EOsBKpZzXCiig1gdrtZI --host <host> --port <port>

        Please remember to change the above password as soon as possible!
        ========================================================================

In this case, `5elsT6KtjrqV` is the password set.
You can then connect to MongoDB:

         mongo admin -u admin -p 5elsT6KtjrqV

Done!


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a randomly generated one, you can
set the environment variable `MONGODB_PASS` to your specific password when running the container:

        docker run -d -p 27017:27017 -e MONGODB_PASS="mypass" -e LANDSAT_PASSWORD="landsatpss" -e USERNAME="landsatuser" --name mongodb astrodigital/ad-monogodb:latest

You can now test your new admin password:

        mongo admin -u admin -p mypass
        curl --user admin:mypass --digest http://localhost:27017/

Run MongoDB without password
----------------------------

If you want to run MongoDB without password you can set the environment variable `AUTH` to specific if you want password or not when running the container:

        docker run -d -p 27017:27017 --name mongodb -e AUTH=no astrodigital/ad-monogodb:latest

By default is "yes".


Run MongoDB with a specific storage engine
------------------------------------------

In MongoDB 3.0 there is a new environment variable `STORAGE_ENGINE` to specific the mongod storage driver:



By default is "wiredTiger".


Change the default oplog size
-----------------------------

In MongoDB 3.0 the variable `OPLOG_SIZE` can be used to specify the mongod oplog size in megabytes:

        docker run -d -p 27017:27017 --name mongodb -e AUTH=no -e OPLOG_SIZE=50 astrodigital/ad-monogodb:latest

By default MongoDB allocates 5% of the available free disk space, but will always allocate at least 1 gigabyte and never more than 50 gigabytes.

