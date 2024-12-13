import AuthenticatedLayout from "@/Layouts/ClinicAuthenticatedLayout";
import { Head, Link } from "@inertiajs/react";
import styles from "./index.module.css";
export default function Index({ auth, appointments }) {
    const subAppointment = appointments.data;
    return (
        <AuthenticatedLayout
            user={auth.user}
            header={
                <div className="flex justify-between">
                    <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                        Appointments
                    </h2>
                </div>
            }
        >
            <Head title="Clinic" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            {/* <pre>
                                {JSON.stringify(appointments, undefined, 2)}
                            </pre> */}
                            <div className="grid grid-cols-2 ">
                                <div className={styles.subContainer}>
                                    <div className="flex justify-between items-center">
                                        <span>Appointments today</span>
                                        <Link className={styles.link}>
                                            See all
                                        </Link>
                                    </div>
                                    <table className={styles.subTable}>
                                        <thead className={styles.subTHead}>
                                            <tr className={styles.subTtr}>
                                                <th>Patient's name</th>
                                                <th>Doctor's name</th>
                                                <th>Hour</th>
                                            </tr>
                                        </thead>
                                        <tbody className={styles.subTBody}>
                                            {subAppointment.map(
                                                (appointment) => (
                                                    <tr
                                                        className={
                                                            styles.subTtr
                                                        }
                                                    >
                                                        <td>
                                                            {
                                                                appointment
                                                                    .patient
                                                                    .name
                                                            }
                                                        </td>
                                                        <td>
                                                            {
                                                                appointment
                                                                    .doctor.name
                                                            }
                                                        </td>
                                                        <td>
                                                            {appointment.time}
                                                        </td>
                                                    </tr>
                                                )
                                            )}
                                        </tbody>
                                    </table>
                                </div>

                                <div className={styles.subContainer}>
                                    Statistic
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
