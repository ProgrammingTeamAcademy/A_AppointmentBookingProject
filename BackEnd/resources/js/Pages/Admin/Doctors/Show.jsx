import AdminAuthenticatedLayout from "@/Layouts/AdminAuthenticatedLayout";
import { Head, Link, router, useForm } from "@inertiajs/react";
import styles from "./index.module.css";
import InputLabel from "@/Components/InputLabel";
import TextInput from "@/Components/TextInput";
import InputError from "@/Components/InputError";
import SelectInput from "@/Components/SelectInput";
import TextAreaInput from "@/Components/TextAreaInput";

export default function Show({ auth, Doctor }) {
    const doctor = Doctor.data;

    return (
        <AdminAuthenticatedLayout
            user={auth.user}
            header={
                <div className={styles.hheader}>
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        Dr. {doctor.name}
                    </h2>
                </div>
            }
        >
            <Head title="New doctor" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100"></div>
                        <div className="px-8">
                            <img
                                src={doctor.image}
                                alt="img"
                                className="h-64 w-fit"
                            />
                            <div className="pt-4 flex">
                                <div className="w-1/2">
                                    <div className="text-white text-lg">
                                        {" "}
                                        doctor name:
                                    </div>
                                    <div className="text-gray-300 pt-1">
                                        {doctor.name}
                                    </div>

                                    <div className="text-white text-lg pt-4">
                                        {" "}
                                        doctor's phone:
                                    </div>
                                    <div className="text-gray-300 pt-1">
                                        {doctor.phone}
                                    </div>
                                    <div className="text-white text-lg pt-4">
                                        {" "}
                                        doctor's email:
                                    </div>
                                    <div className="text-gray-300 pt-1">
                                        {doctor.email}
                                    </div>
                                </div>
                                <div className="w-1/2">
                                    <div className="text-white text-lg">
                                        {" "}
                                        doctor's specialist:
                                    </div>
                                    <div className="text-gray-300 pt-1">
                                        {doctor.specialist}
                                    </div>

                                    <div className="text-white text-lg pt-4">
                                        {" "}
                                        doctor's working clinic:
                                    </div>
                                    <div className="text-gray-300 pt-1">
                                        {doctor.clinic}
                                    </div>
                                </div>
                            </div>

                            {doctor.short_description ? (
                                <div>
                                    <div className="text-white text-lg pt-4">
                                        Description:
                                    </div>
                                    <div className="text-gray-300 pt-1 pb-4">
                                        {doctor.short_description
                                            ? doctor.short_description
                                            : "No description"}
                                    </div>
                                </div>
                            ) : (
                                <div></div>
                            )}

                            {doctor.about_doctor ? (
                                <div>
                                    <div className="text-white text-lg pt-4">
                                        About doctor:
                                    </div>
                                    <div className="text-gray-300 pt-1 pb-4">
                                        {doctor.about_doctor
                                            ? doctor.about_doctor
                                            : "No description"}
                                    </div>
                                </div>
                            ) : (
                                <div></div>
                            )}
                            <div className="mt-4"></div>
                        </div>
                    </div>
                </div>
            </div>
        </AdminAuthenticatedLayout>
    );
}
