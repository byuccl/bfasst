# Getting Started

This documents how to get started with Conformal LEC.

## Accessing

Conformal is currently only registered to be used on the CAEDM server. This can
be accessed by `ssh`ing into the CAEDM server.

  1. Use `ssh` to access your caedm account
     * Ex: <code>ssh <b><i>username</i></b>@ssh.et.byu.edu</code>
  2. Add the following to your `~/.bashrc`:

        ```bash
        export PATH="$PATH":/ee2/Cadence/CONFRML152/bin/
        source /ee2/Cadence/local/designkits/ee451/cdssetup/bashrc_cadence
        ```

  3. Execute the command `source ~/.bashrc` or open a new terminal
  4. Start Conformal by executing the command `lec`

### Note

If you want to use Conformal in GUI mode, you will need to `ssh` using `-X`,
like so: <code>ssh <b><i>username</i></b>@ssh.et.byu.edu -X</code>


## Running

To run Conformal LEC, simply type `lec` into the terminal after you have
accessed the CAEDM server via `ssh`. If you started the `ssh` session using `-X`
then it will open in GUI mode. If not, then it will run via the command line.

### Note

If you want to know what options you can pass `lec` on startup, you can use the
command `lec --help`.
