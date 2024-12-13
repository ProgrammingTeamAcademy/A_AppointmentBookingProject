import AdminAuthenticatedLayout from "@/Layouts/AdminAuthenticatedLayout";
import { Head, Link, router, useForm } from "@inertiajs/react";
import styles from "./index.module.css";
import InputLabel from "@/Components/InputLabel";
import TextInput from "@/Components/TextInput";
import InputError from "@/Components/InputError";
import SelectInput from "@/Components/SelectInput";
import TextAreaInput from "@/Components/TextAreaInput";

export default function Show({ auth, Clinic, doctors }) {
    const clinic = Clinic.data;
    const Doc = doctors.data.filter((d) =>
        d.doctorClinics ? d.doctorClinics.clinic_id == clinic.id : null
    );

    return (
        <AdminAuthenticatedLayout
            user={auth.user}
            header={
                <div className={styles.hheader}>
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        {clinic.name}
                    </h2>
                </div>
            }
        >
            <Head title="New Clinic" />
            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100"></div>
                        <div className="px-8">
                            <img
                                src={clinic.image}
                                alt="img"
                                className="h-64 w-fit"
                            />
                            <div className="pt-4 flex">
                                <div className="w-1/2">
                                    <div className="text-black text-lg">
                                        {" "}
                                        Clinic name:
                                    </div>
                                    <div className="text-gray-500 pt-1">
                                        {clinic.name}
                                    </div>

                                    <div className="text-black text-lg pt-4">
                                        {" "}
                                        Clinic's phone:
                                    </div>
                                    <div className="text-gray-500 pt-1">
                                        {clinic.phone}
                                    </div>
                                </div>
                                <div className="w-1/2">
                                    <div className="text-black text-lg">
                                        {" "}
                                        Clinic's city:
                                    </div>
                                    <div className="text-gray-500 pt-1">
                                        {clinic.province}
                                    </div>

                                    <div className="text-black text-lg pt-4">
                                        {" "}
                                        Clinic's address:
                                    </div>
                                    <div className="text-gray-500 pt-1">
                                        {clinic.address}
                                    </div>
                                </div>
                            </div>
                            <div className="text-black text-lg pt-4">
                                {" "}
                                Description:
                            </div>
                            <div className="text-gray-500 pt-1 pb-4">
                                {clinic.about ? clinic.about : "No description"}
                            </div>
                        </div>
                    </div>

                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg mt-4">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            <div className="text-xl">Clinic's doctors</div>
                            <table className={styles.table}>
                                <thead className={styles.headtable}>
                                    <tr className={styles.tableheadtr}>
                                        <th
                                            onClick={(e) => sortByFun("id")}
                                            className={styles.tableht}
                                        >
                                            Id
                                        </th>
                                        <th className={styles.tableht}>
                                            Image
                                        </th>
                                        <th
                                            onClick={(e) => sortByFun("name")}
                                            className={styles.tableht}
                                        >
                                            Name
                                        </th>
                                        <th
                                            onClick={(e) => sortByFun("email")}
                                            className={styles.tableht}
                                        >
                                            Email
                                        </th>
                                        <th
                                            onClick={(e) => sortByFun("phone")}
                                            className={styles.tableht}
                                        >
                                            Phone no
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("about_doctor")
                                            }
                                            className={styles.tableht}
                                        >
                                            Description
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("short_dscription")
                                            }
                                            className={styles.tableht}
                                        >
                                            Short des
                                        </th>
                                        <th
                                            onClick={(e) =>
                                                sortByFun("created_at")
                                            }
                                            className={styles.tableht}
                                        >
                                            Created Date
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {Doc.length > 0 ? (
                                        Doc.map((doctor) => (
                                            <tr>
                                                <td className={styles.tabletd}>
                                                    {doctor.id}
                                                </td>
                                                <td className={styles.tabletd}>
                                                    <img
                                                        src={doctor.image}
                                                        style={{
                                                            width: 60,
                                                            height: 60,
                                                        }}
                                                    />
                                                </td>
                                                <td
                                                    className={
                                                        styles.tabletdname
                                                    }
                                                >
                                                    <Link
                                                        href={route(
                                                            "doctors.show",
                                                            doctor.id
                                                        )}
                                                    >
                                                        {doctor.name}
                                                    </Link>
                                                </td>
                                                <td className={styles.tabletd}>
                                                    {
                                                        doctor.doctorClinics
                                                            .clinic_id
                                                    }
                                                </td>
                                                <td className={styles.tabletd}>
                                                    {doctor.phone}
                                                </td>
                                                <td className={styles.tabletd}>
                                                    {doctor.about_doctor}
                                                </td>
                                                <td className={styles.tabletd}>
                                                    {doctor.short_description}
                                                </td>
                                                <td className={styles.tabletd}>
                                                    {doctor.createdAt}
                                                </td>
                                            </tr>
                                        ))
                                    ) : (
                                        <div className="mt-4 text-black text-base font-bold text-nowrap">
                                            There is no doctors yet
                                        </div>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </AdminAuthenticatedLayout>
    );
}
