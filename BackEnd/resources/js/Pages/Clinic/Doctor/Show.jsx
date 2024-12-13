import AuthenticatedLayout from "@/Layouts/ClinicAuthenticatedLayout";
import { Head, Link, router, useForm } from "@inertiajs/react";
import doctorPic from "../../../Images/doctor-default.jpg";
import styles from "./show.module.css";
import { useState } from "react";

export default function Show({ auth, doctor }) {
    function actInc(doctor) {
        if (
            !window.confirm(
                `Are you sure you want to ${
                    doctor.status == "yes" ? "inactive" : "active"
                } Dr. ${doctor.name}?`
            )
        ) {
            return;
        }
        router.put(route("cdoctor.activeDoctor", doctor.id));
    }

    function deleteDoctor(doctor) {
        if (
            !window.confirm(
                `Are you sure you want to delete Dr. ${doctor.name}?`
            )
        ) {
            return;
        }
        router.delete(route("cdoctor.delete", doctor.id));
    }

    return (
        <AuthenticatedLayout
            user={auth.user}
            header={
                <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                    Dr. {doctor.data.name}
                </h2>
            }
        >
            <Head title={doctor.data.name} />
            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            <div>
                                <div className={styles.header}>
                                    <div className={styles.imgg}>
                                        <img
                                            srcSet={
                                                doctor.image
                                                    ? doctor.image
                                                    : doctorPic
                                            }
                                            alt=""
                                        />
                                        <div className={styles.name}>
                                            Dr. {doctor.data.name}
                                            <p>{doctor.data.specialist}</p>
                                        </div>
                                    </div>
                                    <div
                                        className={
                                            doctor.data.status == "yes"
                                                ? styles.conditionActive
                                                : styles.conditionInactive
                                        }
                                    >
                                        {doctor.data.status == "yes"
                                            ? "Active"
                                            : "Inactive"}
                                    </div>
                                </div>
                                <div className={styles.main}>
                                    {/* short des */}
                                    <div className={styles.title}>
                                        <span>Short description</span>
                                    </div>
                                    <div className={styles.shortDes}>
                                        {doctor.data.short_description}
                                    </div>
                                    {/* email */}
                                    <div className={styles.title}>
                                        <span>Email</span>
                                    </div>
                                    <div className={styles.subtitle}>
                                        {doctor.data.email}
                                    </div>
                                    {/* phone */}
                                    <div className={styles.title}>
                                        <span>Phone number</span>
                                    </div>
                                    <div className={styles.subtitle}>
                                        {doctor.data.phone}
                                    </div>
                                    {/* work days */}
                                    <div className={styles.title}>
                                        <span>Working days</span>
                                    </div>
                                    <div className={styles.subtitle}>
                                        {doctor.data.doctorClinics.times}
                                    </div>
                                    {/* price */}
                                    <div className={styles.title}>
                                        <span>Examination price</span>
                                    </div>
                                    <div className={styles.subtitle}>
                                        $ {doctor.data.doctorClinics.price}
                                    </div>
                                    {/* work since */}
                                    <div className={styles.title}>
                                        <span>Member since</span>
                                    </div>
                                    <div className={styles.subtitle}>
                                        {doctor.data.doctorClinics.created_at}
                                    </div>
                                    {/* about_doctor */}
                                    <div className={styles.title}>
                                        <span>About doctor</span>
                                    </div>
                                    <div className={styles.subtitle}>
                                        {doctor.data.about_doctor}
                                    </div>
                                </div>
                                <div className={styles.bottomNav}>
                                    <from>
                                        <button
                                            className={
                                                doctor.data.status == "yes"
                                                    ? styles.inactive
                                                    : styles.active
                                            }
                                            onClick={(e) => actInc(doctor.data)}
                                        >
                                            {doctor.data.status == "yes"
                                                ? "Inactive"
                                                : "Active"}
                                        </button>
                                    </from>
                                    <button
                                        className={styles.delete}
                                        onClick={(e) =>
                                            deleteDoctor(doctor.data)
                                        }
                                    >
                                        Delete doctor
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
