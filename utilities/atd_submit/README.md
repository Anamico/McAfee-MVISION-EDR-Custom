# McAfee-MVISION-EDR-Custom Utilities atd_submit

This is an open-source minimal python script as an example of how to create a self-contained packaged python executable you could use in custom McAfee EDR reactions.

To create the executable for this example, clone this repo, then install pyinstaller:

```bash
pip install pyinstaller
```

then you can create the distributables with the following command:

```bash
pyinstaller atd_submit.py
```

For an example of how to deploy and execute it from an EDR custom reaction, see the submitToATD custom reaction example in this repository.