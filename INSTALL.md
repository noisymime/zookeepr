Zookeepr Installation Instructions
==================================

External dependencies
---------------------

 * libpq-dev
 * libpython-dev
 * libxslt1-dev
 * libxml2-dev
 * postgresql
 * python-virtualenv


Creating a development environment
----------------------------------

1. Create a postgresql database for your ZooKeepr instance. The first command creates the database user, the second the database itself, with the zookeepr user as the admin user, and the third assigns a password to the zookeepr user.

    ```
    sudo -u postgres createuser --no-createdb --no-createrole --no-superuser zookeepr
    sudo -u postgres createdb -O zookeepr zk
    sudo -u postgres psql --command "ALTER USER zookeepr with PASSWORD 'zookeepr'"
    ```

2. Create a virtualenv for your ZooKeepr instance.
        ```
        \# using only virtualenv
        virtualenv env --no-site-packages
        . ./env/bin/activate

        \# using virtualenwrapper
        mkvirtualenv zookeepr # --no-site-packages is default
        workon zookeepr
        ```

3. Configure the virtual environment.

        ```
        cp zkpylons/config/lca_info.py.sample zkpylons/config/lca_info.py
        cp development.ini.sample development.ini
        python setup.py develop
        ```

    Edit development.ini to set sqlachemy.url to match your postgresql database.
    _Note: You must set sqlachemy.url in both the [app:main] and [alembic] sections_

4. Now we populate the database. Run alembic to create and populate the initial database.
        ```
        alembic --config development.ini upgrade head
        ```

        WARNING: On a vanilla trunk this does not currently work but there
        is a workaround:

            * Zookeepr is using alembic in a rather unusual way, which leads to
            problems. James has a work-around for this, but it is not currently in
            master and should never be committed to master. The work-around can be
            cherry-picked, commit daa1702ec4522a991c5f75b17cb27e15375d2631 from
            the nasty-db-import-fix branch.

            ```
            git cherry-pick daa1702ec4522a991c5f75b17cb27e15375d2631
            alembic --config development.ini upgrade head
            ```

            To verify the fix, use the alembic history command and check that the
            head revision is "This revision is a lie and should always be head".
            `alembic --config development.ini history`

            ```
            git reset --hard HEAD^
            ```

            Now, we verify that the revision is no longer present, using the command;
            `alembic --config development.ini history`

            The phrase 'This revision is a lie' should *no longer* be present.

5. Run the development server.
        ```
        pserve --reload development.ini
        ```

6. The default admin account is:
        ```
        email: admin@zookeepr.org
        password: password
        ```

You should now have a development instance of ZooKeepr up and running.

Access it at: <http://0.0.0.0:6543>

*Congratulations*
