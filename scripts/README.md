# scripts

Utility scripts to be added to the `$PATH`.

## Symlinks

Link all the files in this directory to a directory that has been added to your `$PATH`.

Note: the source directory may need an absolute path for this to work successfully.

```bash
# Copy all files to destination directory
ln -s $(pwd)/scripts/* /path/to/destination
```
