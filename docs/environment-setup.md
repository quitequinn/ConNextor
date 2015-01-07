### PostgreSQL Installation

A detailed version of this walkthrough can be found on the [PostgreSQL documentation](http://www.postgresql.org/docs/9.3/static/admin.html).

We will install PostgreSQL from source because we are thugs.

_Note: root permissions may be needed_

Download the tarball:

```bash
curl -L https://ftp.postgresql.org/pub/source/v9.3.5/postgresql-9.3.5.tar.gz > postgresql-9.3.5.tar.gz
```

Then, extract the tarball and go into its contents:

```bash
tar zxvf postgresql-9.3.5.tar.gz
cd postgresql-9.3.5
```

PostgreSQL comes with a configuration script, which will determine system environmental variables. We will use the default values in this installation, which will install everything in the directory `/usr/local/pgsql`. Run this script: 

```bash
./configure
```

After the procedure is finished, we will compile the source code using GNU make. (some distributions call it gmake). This will take a while.

```bash
make world
```

It should say something like 

> PostgreSQL, contrib and HTML documentation successfully made. Ready to install.

We could run regression tests on this newly build code. _This is somewhat pointless though, as, if something does go wrong, I have no idea how to fix it..._

```bash
make check
```

It would be perfect if it says something like:

> All 136 tests passed.

Now we install, with root permissions.

```bash
sudo make install
sudo make install-world
```

If regression tests all passed, then there should be no problems. It would give a notification like:

> PostgreSQL, contrib, and documentation installation complete.

It will be useful if we tell the system where to find the PostgreSQL binary and libraries files. Put this at the end of your shell configuration file (found at `~/.bashrc` or `~/.zshrc`)

```bash
LD_LIBRARY_PATH=/usr/local/pgsql/lib
export LD_LIBRARY_PATH
PATH=/usr/local/pgsql/bin:$PATH
export PATH
MANPATH=/usr/local/pgsql/man:$MANPATH
export MANPATH
```

Now restart your shell. You could test whether your paths are configured correctly:

```bash
which initdb
```

which should output

> /usr/local/pgsql/bin/initdb

---

### PostgreSQL Server Setup

It is proper practice to create a new account to manage PostgreSQL. [Read more](http://www.postgresql.org/docs/9.3/static/postgres-user.html)

Here, we will create a user called `postgres`. (No home directory is needed for this user) You may need root permissions for these instructions. 

```bash
sudo su
useradd -m postgres
```

Before creating a database cluster, we need a place to put it first, and change its permissions to the managing user, `postgres`. So still substituting the root user, we create some directories

```bash
mkdir /usr/local/pgsql/data
chown postgres /usr/local/pgsql/data
```

Now we switch to user `postgres`:

```bash
su - postgres
```

Since this is a new user, it may not have its `PATH` configured correctly, so we access binary files with their absolute path. Let us create a database cluster.

```bash
/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data initdb
```

This will fill the directory `/usr/local/pgsql/data/` with some basic files owned by user `postgres`. It will also create some templates for databases. 

We will be using `pg_ctl` for starting and stopping the database server. [Read more](http://www.postgresql.org/docs/9.3/static/app-pg-ctl.html)

Note: While this cluster is safe under the user `postgres`, the PostgreSQL will still allow connection from any user. 

To start the database server:

```bash
/usr/local/pgsql/bin/pg_ctl start -D /usr/local/pgsql/data -l logfile
```

This will create a file called `logfile` in the current directory.

To stop the database server:

```bash
/usr/local/pgsql/bin/pg_ctl stop
```

Now, these commands must be used with the `postgres` user, which could get tiring very quick. Luckily, PostgreSQL comes with scripts that automate this process. 

These scripts are inside the source code package under

```bash
contrib/start-scripts/
```

Move the corresponding script to your home directory or `init.d` directory. These scripts can be used with any user:

```bash
sudo bash script-name start
sudo bash script-name stop
```

You can also configure these to be managed by the system. (this procedure varies with distribution)

---

### PostgreSQL Database Setup

Once the database server is running, we can call the following command with any user, to go into the database terminal:

```bash
psql -U postgres -d dbname
```

By default, a database cluster called `postgres` is created when we initialized our database. We will create our own cluster shortly.

This accesses the database `dbname` with user `postgres` who is the manager of our database system. Note that we do not require any login or password, but only the username of the user. This is only true in the shell. 

We need to first create a database cluster.

```sql
CREATE DATABASE test;
```

We should create a new role that accesses the database but is not the managing user. We call this our client, which the application will use to connect (without administrative permissions). 

```sql
CREATE ROLE testclient LOGIN;
```

The `LOGIN` term permits us to access the shell with this user. That is:

```bash
psql -U testclient -d test
```

However, by separating server from client, we need to constantly grant permissions on tables and sequences to this user. We will see this in our `.ddl` files.

Now we exit the database shell:

```sql
\q
```

And we can access our newly created database cluster:

```bash
psql -U postgres -d test
```

To get up-to-date with the current project database, simply redirect the file to `stdin` stream

```bash
psql -U postgres -d dbname < database.ddl
```


We will keep a most up-to-date Data Definition Language file, which will be stored in the `docs` folder of our project. 

---

### Ruby and Rails Installation

We will use Ruby Version Manager (RVM) to easily install versions of Ruby we want. 

Please uninstall any previous traces of Ruby on the system.

Similar to the installation of PostgreSQL, we will use `curl` to retrieve `rvm` first, only difference is that this time we will get the binary file directly and not compile from source.

```bash
curl -L get.rvm.io > rvm-installer
bash rvm-installer
```

As a result, the directory `~/.rvm/` will be created. We need to add its scripts to our shell. Put this at the end of your shell configuration file (found at `~/.bashrc` or `~/.zshrc`)

```bash
source $HOME/.rvm/scripts/rvm
```

Restart your shell, and run:

```bash
rvm autolibs packages
```

This will install some system libraries and utilies, and give it permission to manage packages.

We now install Ruby 2.1.5 and its docs (it may prompt for `sudo` permissions)

```bash
rvm install 2.1.5
rvm docs generate-ri
rvm use --default 2.1.5
ruby -v
```

RVM can list the full list of Ruby versions with

```bash
rvm list
```

You should now have access to Interactive Ruby:

```bash
irb
```

```ruby
def sum(a, b)
  a + b
end
sum(3, 4)
sum("cat", "dog")
exit
```

We can now install Rails. We can simply get the most updated version:

```bash
gem install rails
```

---

Depending on front-end needs, we may have HTML, JavaScript and CSS preprocessors. We will set them up as we require them.
