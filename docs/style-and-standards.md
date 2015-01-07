### General

Make sure any commits must work in local environment first. And always pull before pushing. 

Always document your code. Good documentation indicates the purpose of a module, how to use it and any precautions one should take while using it.

---

### Structured Query Language

We will try to normalize our database tables to meet the 3rd or 4th Normal Form. This is to minimize information duplication and will eliminate update anomalies. See definitions and examples of Normal Forms on [Wikipedia](http://en.wikipedia.org/wiki/Database_normalization). 

We coin the term "bind" to normalize two tables, e.g. `projects` and `proj_tags` which are not contained within each other. That is, each project may have many tags, and each tag may have many projects. We see this as a subgraph (of the entire data model) where the vertices are all entries in projects and tags. We then make a new table of edges called `proj_to_tag(proj_id, tag_id)` that "binds" a project to a tag, and add an constraint that this relation is unique. Therefore, all entries within `projects` forms a coclique in the subgraph because projects are independent. This subgraph is what's called a bipartite graph. A project `a` has tag `t` if `(a, t)` is in `proj_to_tag`. This makes it easy to add a new tag, delete a tag, associate a project with a tag, etc. But joins are necessary to get the names of all tags of a project.

The naming conventions of SQL is that all keywords are fully capitalized, and table names, column names and type names are not capitalized and separated by underscores. Make sure to always end a command with a semicolon.

---

### Data Definition Language

The naming convention of `.sql` files will be

```
connextor.YYYY.MM.DD.sql
```

Be careful not to use the tab character inside `.sql` files. This will cause issues. Use spaces for padding.

And we must keep all old versions of this file. Edits to this file must be saved as a new `.sql` file. We should create delta files as well but this isn't as important during development, as it is during production.

EDIT: (2015.01.07) Changed suffix `.ddl` to `.sql` for better recognition on GitHub.

---

