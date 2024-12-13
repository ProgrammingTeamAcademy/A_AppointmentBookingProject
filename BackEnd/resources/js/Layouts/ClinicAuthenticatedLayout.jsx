import React, { useState } from "react";
import ApplicationLogo from "@/Components/ApplicationLogo";
import Dropdown from "@/Components/Dropdown";
import NavLink from "@/Components/NavLink";
import ResponsiveNavLink from "@/Components/ResponsiveNavLink";
import { Link, router } from "@inertiajs/react";
import Box from "@mui/material/Box";
import Drawer from "@mui/material/Drawer";
import Button from "@mui/material/Button";
import List from "@mui/material/List";
import Divider from "@mui/material/Divider";
import styles from "./clinicAuth.module.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
    faBars,
    faArrowRightFromBracket,
    faHouse,
    faUserDoctor,
    faUser,
    faCalendarCheck,
    faBell,
    faGear,
} from "@fortawesome/free-solid-svg-icons";
import logo from "../Images/338.png";

export default function Authenticated({ user, header, children }) {
    const [showingNavigationDropdown, setShowingNavigationDropdown] =
        useState(false);
    const [open, setOpen] = React.useState(false);

    const toggleDrawer = (newOpen) => () => {
        setOpen(newOpen);
    };
    const listDrawer = [
        {
            text: "Home",
            icon: faHouse,
            action: () => router.get(route("dashboard")),
        },
        {
            text: "Doctors",
            icon: faUserDoctor,
            action: () => router.get(route("cdoctor.index")),
        },
        {
            text: "Appointments",
            icon: faCalendarCheck,
            action: () => router.get(route("cappointment.index")),
        },
        {
            text: "Notifications",
            icon: faBell,
            action: () => router.post(route("clinic")),
        },
        {
            text: "Profile",
            icon: faUser,
            action: () => router.get(route("profile.edit")),
        },
        {
            text: "Settings",
            icon: faGear,
            action: () => router.post(route("clinic")),
        },
        {
            text: "Logout",
            icon: faArrowRightFromBracket,
            action: () => router.post(route("logout")),
        },
    ];
    const DrawerList = (
        <Box
            sx={{ width: 250 }}
            role="presentation"
            onClick={toggleDrawer(false)}
        >
            <List>
                {listDrawer.map((item, index) => (
                    <div className={styles.listItem}>
                        <button onClick={item.action}>
                            <div className="h-10 px-4 flex pt-2">
                                <div className="pr-8">
                                    <FontAwesomeIcon
                                        icon={item.icon}
                                        size="sm"
                                    />
                                </div>
                                <div>{item.text}</div>
                            </div>
                        </button>
                    </div>
                ))}
            </List>
        </Box>
    );
    function submit(e, text) {
        e.preventDefault();
        if (text == "Logout") {
        }
    }
    return (
        <div className="min-h-screen bg-gray-100 dark:bg-gray-900">
            <nav className="bg-white dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="flex justify-between h-16">
                        <div className="flex">
                            <div className="shrink-0 flex items-center">
                                <Button onClick={toggleDrawer(true)}>
                                    <FontAwesomeIcon
                                        icon={faBars}
                                        size="lg"
                                        color="#22c55e"
                                    />
                                </Button>
                                <Drawer
                                    open={open}
                                    onClose={toggleDrawer(false)}
                                >
                                    {DrawerList}
                                </Drawer>
                            </div>
                            <div>
                                <img src={logo} className="w-16 " alt="" />
                            </div>
                        </div>
                        <div className="flex">
                            <div className="hidden space-x-8 sm:-my-px sm:ms-10 sm:flex">
                                <NavLink
                                    href={route("clinic.dashboard")}
                                    active={route().current("clinic.dashboard")}
                                >
                                    Dashboard
                                </NavLink>
                                <NavLink
                                    href={route("cdoctor.index")}
                                    active={route().current("cdoctor.index")}
                                >
                                    Doctors
                                </NavLink>
                                <NavLink
                                    href={route("cappointment.index")}
                                    active={route().current(
                                        "cappointment.index"
                                    )}
                                >
                                    Appointments
                                </NavLink>
                            </div>
                        </div>

                        {/* <div className="hidden sm:flex sm:items-center sm:ms-6">
                            <div className="ms-3 relative">
                                <Dropdown>
                                    <Dropdown.Trigger>
                                        <span className="inline-flex rounded-md">
                                            <button
                                                type="button"
                                                className="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-800 hover:text-gray-700 dark:hover:text-gray-300 focus:outline-none transition ease-in-out duration-150"
                                            >
                                                {user.name}
                                            </button>
                                        </span>
                                    </Dropdown.Trigger>

                                    <Dropdown.Content>
                                        <Dropdown.Link href={route('profile.edit')}>Profile</Dropdown.Link>
                                        <Dropdown.Link
                                            href={route("logout")}
                                            method="post"
                                            as="button"
                                        >
                                            Log Out
                                        </Dropdown.Link>
                                    </Dropdown.Content>
                                </Dropdown>
                            </div>
                        </div> */}

                        {/* <div className="-me-2 flex items-center sm:hidden">
                            <button
                                onClick={() =>
                                    setShowingNavigationDropdown(
                                        (previousState) => !previousState
                                    )
                                }
                                className="inline-flex items-center justify-center p-2 rounded-md text-gray-400 dark:text-gray-500 hover:text-gray-500 dark:hover:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-900 focus:outline-none focus:bg-gray-100 dark:focus:bg-gray-900 focus:text-gray-500 dark:focus:text-gray-400 transition duration-150 ease-in-out"
                            >
                                <svg
                                    className="h-6 w-6"
                                    stroke="currentColor"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                >
                                    <path
                                        className={
                                            !showingNavigationDropdown
                                                ? "inline-flex"
                                                : "hidden"
                                        }
                                        strokeLinecap="round"
                                        strokeLinejoin="round"
                                        strokeWidth="2"
                                        d="M4 6h16M4 12h16M4 18h16"
                                    />
                                    <path
                                        className={
                                            showingNavigationDropdown
                                                ? "inline-flex"
                                                : "hidden"
                                        }
                                        strokeLinecap="round"
                                        strokeLinejoin="round"
                                        strokeWidth="2"
                                        d="M6 18L18 6M6 6l12 12"
                                    />
                                </svg>
                            </button>
                        </div> */}
                    </div>
                </div>

                <div
                    className={
                        (showingNavigationDropdown ? "block" : "hidden") +
                        " sm:hidden"
                    }
                >
                    <div className="pt-2 pb-3 space-y-1">
                        <ResponsiveNavLink
                            href={route("dashboard")}
                            active={route().current("dashboard")}
                        >
                            Dashboard
                        </ResponsiveNavLink>
                    </div>

                    <div className="pt-4 pb-1 border-t border-gray-200 dark:border-gray-600">
                        <div className="px-4">
                            <div className="font-medium text-base text-gray-800 dark:text-gray-200">
                                {user.name}
                            </div>
                            <div className="font-medium text-sm text-gray-500">
                                {user.email}
                            </div>
                        </div>

                        <div className="mt-3 space-y-1">
                            <ResponsiveNavLink href={route("profile.edit")}>
                                Profile
                            </ResponsiveNavLink>
                            <ResponsiveNavLink
                                method="post"
                                href={route("logout")}
                                as="button"
                            >
                                Log Out
                            </ResponsiveNavLink>
                        </div>
                    </div>
                </div>
            </nav>

            {header && (
                <header className="bg-white dark:bg-gray-800 shadow">
                    <div className="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                        {header}
                    </div>
                </header>
            )}

            <main>{children}</main>
        </div>
    );
}
