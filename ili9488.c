// SPDX-License-Identifier: GPL-2.0

#include <linux/init.h>
#include <linux/module.h>
#include <linux/utsname.h>
#include <linux/timekeeping.h>

static char *who = "Underview";
module_param(who, charp, 0644);
MODULE_PARM_DESC(who, "nice to meet");

static time64_t init_time;

static int __init hello_init(void)
{
	pr_info("Hello %s. You are currently using Linux %s.\n", who, utsname()->release);
	init_time = ktime_get_seconds();
	return 0;
}

static void hello_exit(void)
{
	pr_info("Goodbye %s. Ths modules lived %lld seconds\n", who, ktime_get_seconds() - init_time);
}

module_init(hello_init);
module_exit(hello_exit);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Underview");
