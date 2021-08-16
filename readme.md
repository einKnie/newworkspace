# newworkspace

Wrapper for starting saved workspace configurations in i3.  
This aims to provide an easily extendable list of predefined
workspace setups for specific use cases.

---

## How does it work?

The workspace configuration consists of two files

* a *script* in scripts/
* a corresponding *layout* in layouts/

A script- and corresponding layout-file **must have the same name**.

The **layout file** can be generated with [i3-save-tree](https://i3wm.org/docs/layout-saving.html), but will need manual adaptations.  
In short, the 'swallows' sections in your *layout*.json must match the x values provided by the programs you want to start. Check those values with `xprop`.

For the **script file**, it is recommended to copy the provided [*scripts/template.sh*](scripts/template.sh) and go on from there. The template also contains detailed instructions.  
In short, just set the *workspace* variable to the desired workspace name and adapt the *cmds* array to the commands you need to start your programs.

Once you have a *script* and *layout* file, you can start your workspace by calling
```
> new_workspace.sh <your workspace name>
```


##### Example

```
# script: scripts/example.sh
# layout: layouts/example.json
> ./new_workspace.sh example
```
