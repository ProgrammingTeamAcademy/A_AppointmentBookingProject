import ApplicationLogo from "@/Components/ApplicationLogo";
import { Link } from "@inertiajs/react";
export default function Guest({ children }) {
    return (
        <div className="max-h-full h-full pt-6 sm:pt-0 bg-gray-100 dark:bg-gray-900">
            <div>{children}</div>
        </div>
    );
}
