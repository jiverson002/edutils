#### `<path>`

If `<perms>` is present, it will be used for any files not covered by a policy.
If not, then the `<perms>` of the parent of `<path>` will be inherited and used
as such.

If `<group>`, `<exclude>` or `<include>` are present, they will apply to any
policy that is applied on this path, until a new `<group>`, `<exclude>` or
`<include>` is encountered.

At least one of `<perms>`, `<policy>...`, or `<path>...` must be present.

```
<path>:
  [<perms>]
  [<group>]
  [<exclude>]
  [<include>]
  [<policy>...]
  [<path>...]
```

---

#### `<perms>`

```
mode:
  file: <mode>
  dir: <mode>
```

```
mode: <mode>
```

is shorthand for

```
mode:
  file: <mode>
  dir:  <mode>
```

where both `file` and `dir` have the same <mode>

---

#### `<policy>`

a policy that will be applied to all files and folders contained within the
current path except for those that are listed in the exclude list.

```
<time>:
  <perms>
```

```
<time>:
  mode: <mode>
```

is shorthand for

```
<time>: <mode>
```

---

#### `<exclude>`

```
exclude: <patlist>
```

---

#### `<include>`

```
include: <patlist>
```

---

#### `<group>`

```
group: <name>
```
