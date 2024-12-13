import styles from "../Pages/Clinic/Doctor/index.module.css";
import { Head, Link, router } from "@inertiajs/react";
import doctorPic from "../Images/doctor-default.jpg";
export default function doctorCard({ doctor }) {
    return (
        <div className={styles.doctorCard}>
            <div>
                <div className={styles.imgg}>
                    <img
                        srcSet={doctor.image ? doctor.image : doctorPic}
                        alt=""
                    />
                </div>
                <div className={styles.name}>Dr. {doctor.name}</div>
                <div className={styles.specialist}>
                    Specialist: {doctor.specialist}
                </div>
                <div className={styles.shortDes}>
                    {doctor.short_description}
                </div>
            </div>
            <div className={styles.btnCon}>
                <Link
                    href={route("cdoctor.show", doctor.id)}
                    className={styles.btn}
                >
                    Show Details
                </Link>
            </div>
        </div>
    );
}
