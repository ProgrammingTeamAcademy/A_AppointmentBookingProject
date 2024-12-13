import AuthenticatedLayout from "@/Layouts/ClinicAuthenticatedLayout";
import { Head, Link, useForm } from "@inertiajs/react";
import DoctorCard from "@/Components/doctorCard";
import styles from "./profile.module.css";
import InputLabel from "@/Components/InputLabel";
import InputError from "@/Components/InputError";
import TextInput from "@/Components/TextInput";
import SelectInput from "@/Components/SelectInput";
import TextAreaInput from "@/Components/TextAreaInput";
export default function Create({ auth, c, provinces, countries }) {
    const clinic = c.data;

    const { data, setData, post, errors, reset } = useForm({
        image: "",
        name: clinic.name || "",
        phone: clinic.phone || "",
        address: clinic.address || "",
        province: clinic.province || "",
        province_id: clinic.province_id || "",
        about: clinic.about || "",
        country: "",
        _method: "put",
    });

    const submitForm = (e) => {
        e.preventDefault();
        post(route("profile.update", clinic.id));
    };
    return (
        <AuthenticatedLayout
            user={auth.user}
            header={
                <h2 className="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                    {clinic.name}
                </h2>
            }
        >
            <Head title="Create doctor" />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900 dark:text-gray-100">
                            <form onSubmit={submitForm} className={styles.form}>
                                {/* image */}

                                {clinic.image && (
                                    <div>
                                        <div className="mb-4">
                                            <img
                                                src={clinic.image}
                                                className="w-56"
                                            />
                                        </div>
                                    </div>
                                )}
                                <div>
                                    <InputLabel
                                        htmlFor="clinic_image"
                                        value="Clinic logo"
                                        className={styles.label}
                                    />
                                    <TextInput
                                        id="clinic_image"
                                        name="image"
                                        type="file"
                                        className={styles.txtInp}
                                        onChange={(e) => {
                                            setData("image", e.target.files[0]);
                                        }}
                                    />
                                    <InputError
                                        message={errors.image}
                                        className="mt-2"
                                    />
                                </div>
                                {/* Pname */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_name"
                                        className={styles.label}
                                        value="Name"
                                    />

                                    <TextInput
                                        id="clinic_name"
                                        type="text"
                                        name="name"
                                        value={data.name}
                                        className={styles.txtInp}
                                        isFocused={true}
                                        onChange={(e) =>
                                            setData("name", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.name}
                                        className="mt-2"
                                    />
                                </div>
                                {/* phone no */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="clinic_phone"
                                        value="Phone number"
                                    />

                                    <TextInput
                                        id="clinic_phone"
                                        type="text"
                                        name="phone"
                                        value={data.phone}
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("phone", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.phone}
                                        className="mt-2"
                                    />
                                </div>

                                {/* country */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_country"
                                        value="Country"
                                    />
                                    <SelectInput
                                        id="clinic_country"
                                        name="country"
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData("country", e.target.value)
                                        }
                                    >
                                        <option value="">Select country</option>
                                        {countries.data.map((country) => (
                                            <option
                                                value={country.id}
                                                key={country.id}
                                            >
                                                {country.country_name}
                                            </option>
                                        ))}
                                    </SelectInput>
                                    <InputError
                                        message={errors.country}
                                        className="mt-2"
                                    />
                                </div>

                                {/* province */}
                                <div className="mt-4">
                                    <InputLabel
                                        htmlFor="clinic_province"
                                        value="Province"
                                    />
                                    <SelectInput
                                        id="clinic_province"
                                        name="province"
                                        className="mt-1 block w-full"
                                        onChange={(e) =>
                                            setData(
                                                "province_id",
                                                e.target.value
                                            )
                                        }
                                    >
                                        <option value="">
                                            Select province
                                        </option>
                                        {provinces.data.map((province) => {
                                            if (
                                                province.country_id ==
                                                data.country
                                            ) {
                                                return (
                                                    <option
                                                        value={province.id}
                                                        key={province.id}
                                                    >
                                                        {province.province}
                                                    </option>
                                                );
                                            }
                                        })}
                                    </SelectInput>
                                    <InputError
                                        message={errors.province}
                                        className="mt-2"
                                    />
                                </div>

                                {/* address */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="clinic_address"
                                        value="Address"
                                    />

                                    <TextAreaInput
                                        id="clinic_address"
                                        type="text"
                                        name="address"
                                        value={data.address}
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("address", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.address}
                                        className="mt-2"
                                    />
                                </div>

                                {/* about */}
                                <div className="mt-4">
                                    <InputLabel
                                        className={styles.label}
                                        htmlFor="clinic_about"
                                        value="Description"
                                    />

                                    <TextAreaInput
                                        id="clinic_about"
                                        type="text"
                                        name="about"
                                        value={data.about}
                                        className={styles.txtInp}
                                        onChange={(e) =>
                                            setData("about", e.target.value)
                                        }
                                    />

                                    <InputError
                                        message={errors.about}
                                        className="mt-2"
                                    />
                                </div>

                                <div className={styles.btns}>
                                    <Link
                                        // href={route("cdoctor.index")}
                                        className={styles.cancel}
                                    >
                                        Cancel
                                    </Link>
                                    <button className={styles.submit}>
                                        Update
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
