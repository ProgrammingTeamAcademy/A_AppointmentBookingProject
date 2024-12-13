import { useEffect } from "react";
import Checkbox from "@/Components/Checkbox";
import GuestLayout from "@/Layouts/GuestLayout";
import InputError from "@/Components/InputError";
import InputLabel from "@/Components/InputLabel";
import PrimaryButton from "@/Components/PrimaryButton";
import TextInput from "@/Components/TextInput";
import { Head, Link, useForm } from "@inertiajs/react";
import styles from "./login.module.css";
import docPhoto from "../../Images/doc1.jpg";
import logo from "../../Images/338.png";

export default function Login({ status, canResetPassword }) {
    const { data, setData, post, processing, errors, reset } = useForm({
        phone: "",
        password: "",
        remember: false,
        type: "clinic",
    });

    useEffect(() => {
        return () => {
            reset("password");
        };
    }, []);

    const setSelect = (e) => {
        setData("type", e);
    };

    const submit = (e) => {
        e.preventDefault();

        post(route("login"));
    };

    return (
        <GuestLayout>
            <Head title="Log in" />

            {status && (
                <div className="mb-4 font-medium text-sm text-green-600">
                    {status}
                </div>
            )}

            <div className={styles.head}>
                <img src={logo} className={styles.logo} alt="" />
                <Link>Register</Link>
                <Link>About us</Link>
                <Link>Contact us</Link>
            </div>

            <div className={styles.con}>
                <div className={styles.divI}>
                    <div className="w-full sm:max-w-md mt-6 px-6 py-4 bg-white dark:bg-gray-800 shadow-md overflow-hidden sm:rounded-lg">
                        <form onSubmit={submit}>
                            <div>
                                <InputLabel htmlFor="phone" value="Phone" />

                                <TextInput
                                    id="phone"
                                    type="text"
                                    name="phone"
                                    value={data.phone}
                                    className="mt-1 block w-full"
                                    autoComplete="username"
                                    isFocused={true}
                                    onChange={(e) =>
                                        setData("phone", e.target.value)
                                    }
                                />

                                <InputError
                                    message={errors.phone}
                                    className="mt-2"
                                />
                            </div>

                            <div className="mt-4">
                                <InputLabel
                                    htmlFor="password"
                                    value="Password"
                                />

                                <TextInput
                                    id="password"
                                    type="password"
                                    name="password"
                                    value={data.password}
                                    className="mt-1 block w-full"
                                    autoComplete="current-password"
                                    onChange={(e) =>
                                        setData("password", e.target.value)
                                    }
                                />

                                <InputError
                                    message={errors.password}
                                    className="mt-2"
                                />
                            </div>
                            <div className="mt-4">
                                <InputLabel htmlFor="Iam" value="Login as" />
                                <div className={styles.switch}>
                                    <div
                                        onClick={() => setSelect("clinic")}
                                        className={
                                            data.type == "clinic"
                                                ? styles.selected
                                                : styles.unSelected
                                        }
                                    >
                                        Clinic
                                    </div>
                                    <div
                                        onClick={() => setSelect("doctor")}
                                        className={
                                            data.type == "doctor"
                                                ? styles.selected
                                                : styles.unSelected
                                        }
                                    >
                                        Doctor
                                    </div>
                                </div>
                            </div>
                            <div className="block mt-4">
                                <label className="flex items-center">
                                    <Checkbox
                                        name="remember"
                                        checked={data.remember}
                                        onChange={(e) =>
                                            setData(
                                                "remember",
                                                e.target.checked
                                            )
                                        }
                                    />
                                    <span className="ms-2 text-sm text-gray-600 dark:text-gray-400">
                                        Remember me
                                    </span>
                                </label>
                            </div>

                            <div className="flex items-center justify-end mt-4">
                                {canResetPassword && (
                                    <Link
                                        href={route("password.request")}
                                        className="underline text-sm text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 dark:focus:ring-offset-gray-800"
                                    >
                                        Forgot your password?
                                    </Link>
                                )}

                                <PrimaryButton
                                    className="ms-4"
                                    disabled={processing}
                                >
                                    Log in
                                </PrimaryButton>
                            </div>
                        </form>
                    </div>
                </div>

                <div className={styles.divImg}>
                    <img className={styles.img} srcSet={docPhoto} alt="pic" />
                </div>
            </div>
        </GuestLayout>
    );
}
