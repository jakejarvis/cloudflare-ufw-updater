# Cloudflare + UFW Rule Updater 🔥 🧱

<p align="center"><img src="https://upload.wikimedia.org/wikipedia/en/a/a2/Cloudflare_logo.svg" width="400"/></p>

<h6 align="center">Inspired by <a href="https://github.com/Paul-Reed/cloudflare-ufw">Paul-Reed/cloudflare-ufw</a> and <a href="https://www.leowkahman.com/2016/05/02/automate-raspberry-pi-ufw-allow-cloudflare-inbound/">Leow Kah Man</a>.</h6>

A simple bash script that downloads a list of IP address ranges (both v4 and v6) [belonging to Cloudflare](https://www.cloudflare.com/ips/) and adds them as rules to UFW (Ubuntu's [Uncomplicated Firewall](https://wiki.ubuntu.com/UncomplicatedFirewall)).

In other words, the easiest way to protect your origin server from direct attacks circumventing Cloudflare's protection.


## Usage

### Run once:

Check your current rules first (`sudo ufw status numbered`); if you're already allowing traffic to ports 80 and 443 from **anywhere**, delete those rules with `sudo ufw rule delete X` (replace X with the matching rule number).

**Make sure you're allowing SSH traffic for yourself before enabling UFW!** Run `sudo ufw allow ssh` to be "safe" — you can restrict SSH to your own IPs later if you'd like to _actually_ be safe. 😉

Download (and skim through it — don't trust strangers on the internet with `sudo` permissions!) and run this script once as root (`sudo bash ./cf-ufw.sh`).

Once you've checked that it worked (`sudo ufw status numbered` once again), you can run `sudo ufw enable` to lock everything down.

<p align="center"><img width="600" alt="Screen Shot 2019-12-06 at 11 41 55 AM copy" src="https://user-images.githubusercontent.com/1703673/70339900-b0f22980-181d-11ea-8c32-67ac0c7640e1.png"></p>

### Run as a daily cron job:

Cloudflare might add new IPs to their lists at any time. Therefore, it's important to keep your UFW rules up-to-date by running this script automatically at a set interval via a [cron job](https://en.wikipedia.org/wiki/Cron).

1. `sudo crontab -e`
2. Add this line to the end and save:
```
@daily /location/of/cf-ufw.sh &> /dev/null
```

If you'd like an interval other than daily, [crontab.guru](https://crontab.guru/) is a nifty tool to generate the syntax to replace `@daily`.


## Customization

`cf-ufw.sh` can easily be modified and adjusted to your liking. By default, it only restricts ports `80` and `443` via TCP — likely the reason you're using Cloudflare in the first place. Those can be changed to any other port number (or literally every port). You can also remove either one of the first two lines if your server isn't using IPv6 or IPv4.

In any case, I'd recommend skimming Ubuntu's [full UFW documentation](https://help.ubuntu.com/community/UFW) before enabling, as it's easy to lock yourself out of your own server if you're not careful!


## License

This project is distributed under the [MIT license](LICENSE.md).
