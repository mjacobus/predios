import React from "react";

export default function Question({ children, ...otherProps }) {
  return (
    <div className="alert alert-success">
      <p>{children}</p>
    </div>
  );
}
