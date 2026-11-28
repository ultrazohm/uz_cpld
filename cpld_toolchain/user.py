"""Installed programmer entry points; developer commands remain checkout-local."""


def main():
    from .standalone import main as run
    return run()


def gui():
    from .programmer_gui import main as run
    return run(standalone=True)


if __name__ == '__main__':
    raise SystemExit(main())
