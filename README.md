# Eye-Protector

BASH script to increase productivity of the users by setting work and rest timers along with brightness controls that the user can setup on his own or use the defaults.

## Usage

Use the following options:
```
Help Options:
  -h  , --help                    Show this help menu

Application Options:
  -wt , --worktimer               Specify the time(in minutes) for work
  -rt , --resttimer               Specify the time(in minutes) for rest
  -v  , --version                 Version of the package.
  -rb , --restore-brightness      If you exit the process before work timer starts, use this option to reset the brightness to default.
  -mb , --min-brightness          Set the brightness that you want during the rest. Possible values between 0 and 0.5.
  -mbf, --min-brightness-force    Set the brightness that you want during the rest. For advanced users only.
```   

## Installation

1. Clone the git repository
```
git clone https://github.com/parasg1999/Eye_Protector/
```

2. ```cd``` to ```Eye-Protector```

3. Change the permissions to make the script executable
```
chmod u+x eye-protector.sh
```

4. Run the script using ```./eye-protector.sh [options]```

## Contributions
I would love to recieve your suggestions. Feel free to make a Pull Request or create an Issue if you want to contribute.
:)
