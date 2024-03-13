import sys
import subprocess
import pkg_resources


def pip_install(module_name):
    required = {module_name}
    installed = {pkg.key for pkg in pkg_resources.working_set}
    missing = required - installed

    if missing:
        python = sys.executable
        subprocess.check_call([python, '-m', 'pip', 'install', *missing], stdout=subprocess.DEVNULL)


if __name__ == '__main__':
    pip_install('Flask')
    pip_install('PyMySQL')
    pip_install('matplotlib')
    pip_install('pandas')
