# scripts

Utility scripts to be added to the `$PATH`.

## Adding Script

1. Create your script in this directory
1. Make it executable:
    ```bash
    chmod u+x <script-name>
    ```
1. Copy it to the destination directory that is monitored by your `$PATH`: 
    ```bash
    ln -s $(pwd)/scripts/<script-name> /path/to/destination/
    ```

## Symlinks

Link all the files in this directory to a directory that has been added to your `$PATH`.

Note: the source directory may need an absolute path for this to work successfully.

```bash
# Copy all files to destination directory
ln -s $(pwd)/scripts/* /path/to/destination
```
